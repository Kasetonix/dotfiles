use std::fs::File;
use std::io::prelude::*;
use std::path::Path;

/* Global variables containing the path to batteries and the ac */
static BAT0: &'static str = "/sys/class/power_supply/BAT0";
static BAT1: &'static str = "/sys/class/power_supply/BAT1";
static NOW:  &'static str = "now";
static FULL: &'static str = "full";

fn get_energy(bat: &str, which: &str) -> i32 {
    let mut value = String::from("0"); /* To return if `bat` isn't connected */

    /* Opening and reading the file if the `bat` is connected */
    if Path::new(bat).exists() { /* e.g /sys/class/power_supply/BAT0/energy_now */
        let mut file = File::open(format!("{}/{}{}", bat, "energy_", which)).expect("Unable to open file.");
        value = String::new();
        file.read_to_string(&mut value).expect("Unable to read file.");
    }
    
    /* return the value parsed into an i32 (divided by 1000 to remove the zeros) */
    value.trim().parse::<i32>().unwrap() / 1000
}

fn get_status(bat: &str) -> String {
    let mut value = String::from("Not charging"); /* To return if `bat` isn't connected */

    /* Opening and reading the file */
    if Path::new(bat).exists() { /* e.g /sys/class/power_supply/BAT0/status */
        let mut file = File::open(format!("{}/{}", bat, "status")).expect("Unable to open file.");
        value = String::new();
        file.read_to_string(&mut value).expect("Unable to read file.");
    }

    /* return the value (without the whitespace characters) */
    value.trim().to_string()
}

fn get_battery_percentage() -> i8 {
    /* Get the sum of the energy stored in both batteries */
    let energy_now:  i32 = get_energy(BAT0, NOW)  + get_energy(BAT1, NOW);
    let energy_full: i32 = get_energy(BAT0, FULL) + get_energy(BAT1, FULL);

    /* Return the percentage of the energy stored in batteries */
    (energy_now * 100 / energy_full).try_into().unwrap()
}

fn draw_charge() -> &'static str {
    let percentage: i8 = get_battery_percentage();

    if percentage >= 95 {
        return " "; 
    }

    let level: i8 = percentage / 25;
    match level {
        3 => return " ", /* >= 75% */
        2 => return " ", /* >= 50% */
        1 => return " ", /* >= 25% */
        0 => return " ", /* >=  0% */
        _ => return "~~"  /* Return a fallback value */
    }
}

fn draw_status() -> &'static str {
    let tmp_status = get_status(BAT0); let bat0_status: &str = String::as_str(&tmp_status);
    let tmp_status = get_status(BAT1); let bat1_status: &str = String::as_str(&tmp_status);
    let percentage: i8 = get_battery_percentage();

    if bat0_status == "Charging" || bat1_status == "Charging" {
        if percentage >= 99 { return ""; } /* Charging and 'Full' */
        else                { return ""; } /* Charging            */
    } else if bat0_status == "Discharging" || bat1_status == "Discharging" {
        if percentage > 10  { return ""; } /* Discharging         */
        else                { return ""; } /* Discharging and low */
    }

    /* Return a fallback value */
    "~"
}

pub fn draw_icon() -> String {
    format!("{} {}", draw_charge(), draw_status())
}
