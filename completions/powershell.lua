local arghelper = require("arghelper")

local file_matches    = clink.argmatcher():addarg(clink.filematches)
local version_matches = clink.argmatcher():addarg({fromhistory=true})
local format_matches  = clink.argmatcher():addarg("Text", "XML")
local style_matches   = clink.argmatcher():addarg("Normal", "Minimized", "Maximized", "Hidden")

clink.argmatcher("powershell")
  :_addexflags({
    { hide=true, "-?" },
    { hide=true, "/?" },
    { "-Help",                                               "Shows help" },
    { "-PSConsoleFile" .. file_matches,    " <file>",        "Loads the specified Windows PowerShell console file." },
    { "-Version"       .. version_matches, " <version>",     "Starts the specified version of Windows PowerShell." },
    { "-NoLogo",                                             "Hides the copyright banner at startup." },
    { "-NoExit",                                             "Does not exit after running startup commands." },
    { "-Sta",                                                "Starts the shell using a single-threaded apartment." },
    { "-Mta",                                                "Start the shell using a multithreaded apartment." },
    { "-NoProfile",                                          "Does not load the Windows PowerShell profile." },
    { "-NonInteractive",                                     "Does not present an interactive prompt to the user." },
    { "-InputFormat"    .. format_matches, " <format>",      "Describes the format of data sent to Windows PowerShell." },
    { "-OutputFormat"   .. format_matches, " <format>",      "Determines how output from Windows PowerShell is formatted." },
    { "-WindowStyle"    .. style_matches,  " <style>",       "Sets the window style" },
    { "-EncodedCommand",                   " <command>",     "Accepts a base-64-encoded string version of a command." },
    { "-ConfigurationName",                " <string>",      "Specifies a configuration endpoint in which Windows PowerShell is run." },
    { "-File"           .. file_matches,   " <file> <args>", "Runs the specified script in the local scope." },
    { "-ExecutionPolicy",                  " <policy>",      "Sets the default execution policy for the current session and saves it in $env:PSExecutionPolicyPreference" },
    { "-Command",                          " <command>",     "Executes the specified commands (and any parameters) as though they were typed at the Windows PowerShell command prompt" },
  })
