use std::process::Command;
use std::process::ExitCode;

fn main() -> ExitCode {
    println!("  {} ", draw_volume_bar());
    ExitCode::SUCCESS
}

fn get_volume() -> i8 {
    let output = Command::new("pamixer").arg("--get-volume").output().expect("pamixer couldn't be run.");
    let mut volume = String::from_utf8(output.stdout).expect("Couldn't capture the pamixer output."); 
    volume = volume.trim().to_string();

    /* Return the result parsed to an i8 */
    volume.parse::<i8>().unwrap()
}

fn draw_volume_bar() -> String {
    /* dividing the volume (in percent) by ten to
     * get the number of full bits in a bar */
    let level = get_volume() / 10;
    let mut bar = String::from("");
    let mut iterator: i8 = 0;

    /* Adding the full bits to the bar */
    while iterator < level {
        bar += "ﭳ";
        iterator += 1;
    }

    /* Adding the empty bits to the bar */
    while iterator < 10 {
        bar += "—";
        iterator += 1;
    }

    bar
}
