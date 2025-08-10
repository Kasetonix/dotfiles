#include <cstdlib>
#include <iostream>
#include <fstream>
#include <string>
#include <sys/ioctl.h>
#include <unistd.h>
#include <vector>
#include <termios.h>
#include <cmath>
#include <cstring>
using std::cout;
using std::cin;
using std::ifstream;
using std::string;
using std::vector;
using std::to_string;
using std::stoi;

// Custom struct for readability
struct windim {
    unsigned int cols;
    unsigned int rows;
};

const unsigned int SCROLL_SPEED = 2;
const unsigned int H_SCROLL_SPEED = 4;

termios CreateTermIOs();
void ArgManager(int argc, char *argv[], string &filename);
vector<string> CreateFileVector(string filename);
void DisplayFile(vector<string> file, string file_path, unsigned int scroll, unsigned int h_scroll, bool run);
bool FileFits(vector<string> file);
void InputManager(bool &run, vector<string> file, unsigned int &scroll, unsigned int &h_scroll);
void Redraw(vector<string> file, string file_path, unsigned int scroll, unsigned int h_scroll, bool run); 

// -------------------------------
int main(int argc, char *argv[]) {
    vector<string> file;
    string file_path;
    termios termios = CreateTermIOs();
    unsigned int scroll = 0, h_scroll = 0;
    bool run = true;

    ArgManager(argc, argv, file_path);
    file = CreateFileVector(file_path);

    DisplayFile(file, file_path, scroll, h_scroll, run);
    if (FileFits(file))
        return 0;

    while (run) {
        InputManager(run, file, scroll, h_scroll); 
        Redraw(file, file_path, scroll, h_scroll, run);
    }

    return 0;
}

// Function creating a TermIOs that prevent keystroke buffering
termios CreateTermIOs() {
    struct termios t;
    tcgetattr(STDIN_FILENO, &t);
    t.c_lflag &= ~ICANON;
    tcsetattr(STDIN_FILENO, TCSANOW, &t);

    return t;
}

// Function getting the window dimensions
windim GetWindowDimensions() {
    winsize winsize;
    // 0 means STDIN
    ioctl(0, TIOCGWINSZ, &winsize);
    return { winsize.ws_col, winsize.ws_row };
}

// Function displaying help information
void DisplayHelp() {
    cout << "/// PLUS ///" << "\n";
    cout << "   Simple terminal pager with line numbering. " << "\n"; 
    cout << "   Written in C++ with no external libraries for Linux-based systems." << "\n";
    cout << "\n";
    cout << "   +> represents line cutoff point." << "\n";
    cout << "\n";
    cout << "   OPTIONS:" << "\n";
    cout << "       -h, --help | --> Displaying this help message" << "\n";
    cout << "\n";
    cout << "   KEYBINDS:" << "\n";
    cout << "       ↑ | --> Scrolling up" << "\n";
    cout << "       ↓ | --> Scrolling down" << "\n";
    cout << "       ← | --> Scrolling left" << "\n";
    cout << "       → | --> Scrolling right" << "\n";
    cout << "       g | --> Scrolling to top" << "\n";
    cout << "       G | --> Scrolling to bottom" << "\n";
    cout << "       0 | --> Scrolling to beginning of the line" << "\n";
    cout << "       $ | --> Scrolling to end of the line" << "\n";
    cout << "       q | --> Quitting the program" << "\n";
    cout << "\n";
}

// Argument Manager
// - int argc         -> number of arguments
// - char *argv[]     -> array of arguments
// - string &filename -> stores the found filename
void ArgManager(int argc, char *argv[], string &filename) {
    unsigned int c_arg;
    bool file_opened = false;

    // Every argument
    for (c_arg = 1; c_arg < argc; c_arg++) {
        // Checking if an option was given
        if (argv[c_arg][0] == '-') {
            // Displaying help
            if (strcmp(argv[c_arg], "-h") || strcmp(argv[c_arg], "--help")) {
                DisplayHelp();
                exit(0);
            } 
        } 

        // Checking if a valid filename was given
        else if (access(argv[c_arg], F_OK) != -1 && !file_opened) {
            filename = argv[c_arg];
            file_opened = true;
        }
    }

    // Exiting the program if no valid filename was given
    if (!file_opened) {
        cout << "No valid file was given." << "\n";
        exit(1);
    }
}

// Function creating a vector containing file's contents
// - string filename -> name of file
vector<string> CreateFileVector(string filename) {
    vector<string> file_text;
    ifstream infile;
    string c_line;

    // Opening the file and pushing all lines into a vector
    infile.open(filename);
    while (getline(infile, c_line))
        file_text.push_back(c_line);

    return file_text;
}

// Function checking if the whole file will fit in a window
// - vector<string> file -> vector of lines contained in the file
bool FileFits(vector<string> file) {
    windim win = GetWindowDimensions();
    // three rows account for original prompt line, statusline, and final prompt line
    return (file.size() <= win.rows - 3);
}

// Function rounding the positive number up
// - double num -> number to be rounded up
int RoundUp(double num) {
    return (int(num) + 1);
}

// Getting only a filename from a path
// - string file_path -> path to the file from which the functions extracts the filename
string GetFilename(string file_path) {
    size_t last_slash_index, filename_len;

    // finding the last occurence of the slash
    last_slash_index = file_path.rfind("/");
    
    // i.e. if there is no slash in the path
    if (last_slash_index == string::npos)
        return file_path;

    filename_len = file_path.size() - last_slash_index;
    return file_path.substr(last_slash_index + 1, filename_len - 1); 
}

// Function displaying a specific line from a file with correct padding
// - vector<string> file -> vector of lines contained in the file
// - unsigned int c_line_num -> line number of the currently printed line
void DisplayLine(vector<string> file, unsigned int c_line_num, unsigned int h_scroll) {
    windim win = GetWindowDimensions();
    unsigned int padding, index;
    string line_num = "", line = file[c_line_num];
    // Calculating the padding needed
    padding = RoundUp(log10(file.size())) - RoundUp(log10(c_line_num + 1));

    // Adding padding
    for (index = 0; index < padding + 1; index++)
        line_num += ' ';
    line_num += to_string(c_line_num + 1);

    // Adding horizontal scrolling
    if (line.length() <= h_scroll)
        line = "";
    else
        line = line.substr(h_scroll, line.length());

    // Cutting off the line if it doesn't fit the screen width
    if (line.length() >= win.cols - line_num.length() - 3)
        line = line.substr(0, win.cols - line_num.length() - 6) + " +>";

    cout << line_num << " │ " << line << "\n";
}

// Function displaying the topline
// - string file_path -> path to the paged file
void DisplayTopline(string file_path) {
    string topline, filename;
    unsigned int char_num;
    windim win = GetWindowDimensions();
    filename = GetFilename(file_path);

    // Adding dashes until we run out of screen space to fit the filename
    for (char_num = 0; char_num < win.cols - filename.size() - 5; char_num++) {
        topline += "—";
    }
    topline += " " + filename + " ———";

    cout << topline << "\n";
}

// Function displaying the statusline (at the bottom)
// - unsigned int scroll -> current scroll value
void DisplayStatusline(unsigned int scroll, unsigned int h_scroll) {
    string s_scroll = "[ SCROLL: " + to_string(scroll) + " ] " + "[ H SCROLL: " + to_string(h_scroll) + " ]";
    cout << s_scroll << " : ";
}

// Function displaying the whole file
// - vector<string> file -> vector of lines contained in the file
// - string file_path -> path to the paged file
// - string scroll -> current scroll value
void DisplayFile(vector<string> file, string file_path, unsigned int scroll, unsigned int h_scroll, bool run) {
    windim win = GetWindowDimensions();
    unsigned int c_line_num, last_line_num;

    // Last line to be printed (accounting for statusline)
    last_line_num = win.rows + scroll - 2;

    DisplayTopline(file_path);
    // Two cases depending on whether the whole file fits in the window
    switch (FileFits(file)) {
        case true: // Displaying only the topline and file contents
            for (c_line_num = 0; c_line_num < file.size(); c_line_num++)
                DisplayLine(file, c_line_num, h_scroll);
            break;
        case false: // Displaying the topline, file contents, and statusline
            if (!run)
                last_line_num--;
            for (c_line_num = scroll; c_line_num < last_line_num; c_line_num++)
                DisplayLine(file, c_line_num, h_scroll);
            DisplayStatusline(scroll, h_scroll);
            break;
    }
}

// Function clearing the screen
void ClearScreen() {
    cout << u8"\033[2J\033[1;1H";
}

// Function for managing input
// - bool &run -> variable telling if the program should be run further
// - vector<string> file -> vector of lines contained in the file
// - unsigned int &scroll -> pointer to scroll - used to update the value globally
// - unsigned int &scroll -> pointer to horizontal scroll - used to update the value globally
void InputManager(bool &run, vector<string> file, unsigned int &scroll, unsigned int &h_scroll) {
    char input, input_add_a, input_add_b;
    string line_num;
    windim win = GetWindowDimensions();
    // Maximum scroll accounting for statusline and topline
    unsigned int max_scroll = file.size() - win.rows + 2;
    int max_h_scroll = 0;
    unsigned int max_line_len = 0, line_padding;

    line_padding = RoundUp(log10(file.size())) + 4;

    // Finding the longest line
    for (int index = 0; index < file.size(); index++)
        max_line_len = file[index].length() > max_line_len ? file[index].length() : max_line_len;

    // Calculating largest h_scroll value
    max_h_scroll = line_padding + max_line_len + 3 - win.cols;
    if (max_h_scroll < 0)
        max_h_scroll = 0;

    if (h_scroll > max_h_scroll)
        h_scroll = max_h_scroll;
    if (scroll > max_scroll)
        scroll = max_scroll;

    cin >> input;

    // Arrows
    if (input == 27) {
        cin >> input_add_a >> input_add_b;

        if (input_add_a == 91) {
            switch (input_add_b) {
                case 65: // UP arrow
                    if (scroll >= SCROLL_SPEED)
                        scroll -= SCROLL_SPEED;
                    else scroll = 0;
                    break;
                case 66: // DOWN arrow
                    if (scroll <= max_scroll - SCROLL_SPEED)
                        scroll += SCROLL_SPEED;
                    else scroll = max_scroll;
                    break;
                case 68: // LEFT arrow
                    if (h_scroll >= H_SCROLL_SPEED)
                        h_scroll -= H_SCROLL_SPEED;
                    else h_scroll = 0;
                    break;
                case 67: // RIGHT arrow
                    if (h_scroll <= max_h_scroll - H_SCROLL_SPEED && max_h_scroll > 0)
                        h_scroll += H_SCROLL_SPEED;
                    else h_scroll = max_h_scroll;
                    break;
            }
        }
    }

    switch (input) {
        case 'q': // Quitting
            cout << "\n";
            run = false;
            break;
        case 'g': // Movement
            scroll = 0;
            break;
        case 'G':
            scroll = max_scroll;
            break;
        case '0':
            h_scroll = 0;
            break;
        case '$':
            h_scroll = max_h_scroll;
            break;
    }

    line_num += input;
    while (input >= '1' && input <= '9') {
        cin >> input;
        if (input == 'G') {
            scroll = stoi(line_num) - 1;
            break;
        } else if (input >= '0' && input <= '9') {
            line_num += input;
            continue;
        } else break;
    }
}

// Function redrawing the screen
void Redraw(vector<string> file, string file_path, unsigned int scroll, unsigned int h_scroll, bool run) {
    ClearScreen();
    DisplayFile(file, file_path, scroll, h_scroll, run);
}
