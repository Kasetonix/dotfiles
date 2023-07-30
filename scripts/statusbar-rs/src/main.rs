use std::process::ExitCode;
use std::io::stdout;
use std::io::Write;

mod caps_lock;
mod volume;
mod brightness;
mod battery;
mod clock;

fn main() -> ExitCode {
    print!(" {} ", caps_lock::draw_icon());
    print!(" {} ", volume::draw_bar());
    print!(" {} ", brightness::draw_bar());
    print!(" {} ", battery::draw_icon());
    print!(" {} ", clock::draw_time());
    println!();
    stdout().flush().expect("Couldn't flush the stdout.");

    ExitCode::SUCCESS
}
