use std::process::Command;
use std::process::ExitCode;
use std::fs::File;
use std::io::prelude::*;

static LID_STATE: &'static str = "/proc/acpi/button/lid/LID/state";

fn main() -> ExitCode {
    if is_lid_open() {
        println!("  {} ", draw_brightness_bar());
    }
    ExitCode::SUCCESS /* Exits the program with exit code for success */ 
}

fn get_brightness() -> i16 {
    /* Getting the current brightness */
    let output = Command::new("brightnessctl").arg("get").output().expect("brightnessctl couldn't be run.");
    let mut brightness_now = String::from_utf8(output.stdout).expect("Couldn't capture the brightness output."); 
    brightness_now = brightness_now.trim().to_string();
    /* Parsing it into i32 */
    let brightness_now: i32 = brightness_now.parse::<i32>().unwrap();

    /* Getting the maximum brightness */
    let output = Command::new("brightnessctl").arg("max").output().expect("brightnessctl couldn't be run.");
    let mut brightness_max = String::from_utf8(output.stdout).expect("Couldn't capture the brightness output."); 
    brightness_max = brightness_max.trim().to_string();
    /* Parsing it into i32 */
    let brightness_max: i32 = brightness_max.parse::<i32>().unwrap();

    /* Return the percentage parsed into an i8 */
    (brightness_now * 100 / brightness_max).try_into().unwrap()
}

fn draw_brightness_bar() -> String {
    /* dividing the brightness (in percent) by ten to
     * get the number of full bits in a bar */
    const BITS: i16 = 4;
    let level: i16 = get_brightness() * BITS / 100;
    let mut bar = String::from("");
    let mut iterator: i16 = 0;

    /* Adding the full bits to the bar */
    while iterator < level {
        bar += "ﭳ";
        iterator += 1;
    }

    /* Adding the empty bits to the bar */
    while iterator < BITS {
        bar += "—";
        iterator += 1;
    }

    bar
}

fn is_lid_open() -> bool {
    /* Define consts for messages */
    const MSG_OPEN: &str   = "state:      open"; 
    const MSG_CLOSED: &str = "state:      closed"; 

    /* Open the file and get the state of the lid */
    let mut file = File::open(LID_STATE).expect("Unable to open file.");
    let mut state = String::new();
    file.read_to_string(&mut state).expect("Unable to read file.");
    state = state.trim().to_string();

    /* match the state against the two options */
    match state.as_str() {
        MSG_OPEN => return true,
        MSG_CLOSED => return false,
        _ => true /* as a fallback */
    }
}
