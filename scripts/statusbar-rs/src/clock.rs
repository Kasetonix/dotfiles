use std::process::Command;

pub fn draw_time() -> String {
    /* Getting the time */
    let output = Command::new("date").arg("+%H:%M").output().expect("date couldn't be run.");
    let time = String::from_utf8(output.stdout).expect("Couldn't capture the date output."); 
    /* Returning the trimmed time */
    time.trim().to_string()
}
