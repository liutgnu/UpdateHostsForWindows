## Update hosts for windows

#### About project

The purpose of the project is to provide a double-click-and-done way to update hosts for Windows easily. This project doesn't maintain hosts itself, ONLY downloads hosts file from [racaljk/hosts](https://github.com/racaljk/hosts) and copy to the right place.

#### Requirements

The project requires Windows PowerShell. 

#### Bugs

Though tested only on Windows7, it's expected to be run on Windows7, Windows8 or higher. Any questions or feedbacks are appreciated. 

#### Why Windows

Because updating hosts for Linux is so easy that it cannot even be called as a project.

#### How does the script work

I'm so glad you reached here, that's the spirit of engineer.

Actually it's a mess. PowerShell scripts (or .ps1) can do downloading and copying tasks, but it cannot be activated by double-click as any other executable programmes, moreover, to run a ps1 script requires "Unrestricted or RemoteSigned ExecutionPolicy", otherwise execution is denied. There are ways to bypass such policy, such as passing "-ExecutionPolicy unrestricted" flags to PowerShell. So the batch file acts as a wrapper, to generate ps1 script and call PowerShell with specific flags.
