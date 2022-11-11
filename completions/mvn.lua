-- argument completion for maven
require("arghelper")

local file_matches     = clink.argmatcher():addarg(clink.filematches)
local dir_matches      = clink.argmatcher():addarg(clink.dirmatches)
local builder_matches  = clink.argmatcher():addarg({fromhistory=true})
local define_matches   = clink.argmatcher():addarg({fromhistory=true})
local profile_matches  = clink.argmatcher():addarg({fromhistory=true})
local project_matches  = clink.argmatcher():addarg({fromhistory=true})
local thread_count     = clink.argmatcher():addarg()

clink.argmatcher("mvn")
  :_addexflags({
    { hide=true, "-am",                                                           "If project list is specified, also build projects required by the list" },
    {            "--also-make",                                                   "If project list is specified, also build projects required by the list" },
    { hide=true, "-amd",                                                          "If project list is specified, also build projects that depend on projects on the list" },
    {            "--also-make-dependents",                                        "If project list is specified, also build projects that depend on projects on the list" },
    { hide=true, "-B",                                                            "Run in non-interactive (batch) mode (disables output color)" },
    {            "--batch-mode",                                                  "Run in non-interactive (batch) mode (disables output color)" },
    { hide=true, "-b"                          .. builder_matches,  " <id>",      "The id of the build strategy to use" },
    {            "--builder"                   .. builder_matches,  " <id>",      "The id of the build strategy to use" },
    { hide=true, "-C",                                                            "Fail the build if checksums don't match" },
    {            "--strict-checksums",                                            "Fail the build if checksums don't match" },
    { hide=true, "-c",                                                            "Warn if checksums don't match" },
    {            "--lax-checksums",                                               "Warn if checksums don't match" },
    { hide=true, "-cpu",                                                          "Ineffective, only kept for backward compatibility" },
    { hide=true, "--check-plugin-updates",                                        "Ineffective, only kept for backward compatibility" },
    { hide=true, "-D"                          .. define_matches,   " <arg>",     "Define a system property" },
    {            "--define"                    .. define_matches,   " <arg>",     "Define a system property" },
    { hide=true, "-e",                                                            "Produce execution error messages" },
    {            "--errors",                                                      "Produce execution error messages" },
    { hide=true, "-emp",                                                          "Encrypt master security password" },
    {            "--encrypt-master-password",                                     "Encrypt master security password" },
    { hide=true, "-ep",                                                           "Encrypt server password" },
    {            "--encrypt-password",                                            "Encrypt server password" },
    { hide=true, "-f"                          .. file_matches,     " <file>",    "Force the use of an alternate POM file (or directory with pom.xml)" },
    {            "--file"                      .. file_matches,     " <file>",    "Force the use of an alternate POM file (or directory with pom.xml)" },
    { hide=true, "-fae",                                                          "Only fail the build afterwards; allow all non-impacted builds to continue" },
    {            "--fail-at-end",                                                 "Only fail the build afterwards; allow all non-impacted builds to continue" },
    { hide=true, "-ff",                                                           "Stop at first failure in reactorized builds" },
    {            "--fail-fast",                                                   "Stop at first failure in reactorized builds" },
    { hide=true, "-fn",                                                           "NEVER fail the build, regardless of project result" },
    {            "--fail-never",                                                  "NEVER fail the build, regardless of project result" },
    { hide=true, "-gs"                         .. file_matches,     " <file>",    "Alternate path for the global settings file" },
    {            "--global-settings"           .. file_matches,     " <file>",    "Alternate path for the global settings file" },
    { hide=true, "-gt"                         .. file_matches,     " <file>",    "Alternate path for the global toolchains file" },
    {            "--global-toolchains"         .. file_matches,     " <file>",    "Alternate path for the global toolchains file" },
    { hide=true, "-h",                                                            "Display help information" },
    {            "--help",                                                        "Display help information" },
    { hide=true, "-l"                          .. file_matches,     " <file>",    "Log file where all build output will go (disables output color)" },
    {            "--log-file"                  .. file_matches,     " <file>",    "Log file where all build output will go (disables output color)" },
    { hide=true, "-llr",                                                          "Use Maven 2 Legacy Local Repository behaviour" },
    {            "--legacy-local-repository",                                     "Use Maven 2 Legacy Local Repository behaviour" },
    { hide=true, "-N",                                                            "Do not recurse into sub-projects" },
    {            "--non-recursive",                                               "Do not recurse into sub-projects" },
    { hide=true, "-npr",                                                          "Ineffective, only kept for backward compatibility" },
    { hide=true, "--no-plugin-registry",                                          "Ineffective, only kept for backward compatibility" },
    { hide=true, "-npu",                                                          "Ineffective, only kept for backward compatibility" },
    { hide=true, "--no-plugin-updates",                                           "Ineffective, only kept for backward compatibility" },
    { hide=true, "-nsu",                                                          "Suppress SNAPSHOT updates" },
    {            "--no-snapshot-updates",                                         "Suppress SNAPSHOT updates" },
    { hide=true, "-o",                                                            "Work offline" },
    {            "--offline",                                                     "Work offline" },
    { hide=true, "-P"                          .. profile_matches,  " <profile>", "Comma-delimited list of profiles to activate" },
    {            "--activate-profiles"         .. profile_matches,  " <profile>", "Comma-delimited list of profiles to activate" },
    { hide=true, "-pl"                         .. project_matches,  " <project>", "Comma-delimited list of specified reactor projects to build instead of all projects" },
    { hide=true, "-projects"                   .. project_matches,  " <project>", "Comma-delimited list of specified reactor projects to build instead of all projects" },
    { hide=true, "-q",                                                            "Quiet output - only show errors" },
    {            "--quiet",                                                       "Quiet output - only show errors" },
    { hide=true, "-rf",                                                           "Resume reactor from specified project" },
    {            "--resume-from",                                                 "Resume reactor from specified project" },
    { hide=true, "-s"                          .. file_matches,     " <file>",    "Alternate path for the user settings file" },
    {            "--settings"                  .. file_matches,     " <file>",    "Alternate path for the user settings file" },
    { hide=true, "-t"                          .. file_matches,     " <file>",    "Alternate path for the user toolchains file" },
    {            "--toolchains"                .. file_matches,     " <file>",    "Alternate path for the user toolchains file" },
    { hide=true, "-T"                          .. thread_count,     " <count>",   "Thread count, for instance 2.0C where C is core multiplied" },
    {            "--threads"                   .. thread_count,     " <count>",   "Thread count, for instance 2.0C where C is core multiplied" },
    { hide=true, "-U",                                                            "Forces a check for missing releases and updated snapshots on remote repositories" },
    {            "--update-snapshots",                                            "Forces a check for missing releases and updated snapshots on remote repositories" },
    { hide=true, "-up",                                                           "Ineffective, only kept for backward compatibility" },
    { hide=true, "--update-plugins",                                              "Ineffective, only kept for backward compatibility" },
    { hide=true, "-v",                                                            "Display version information" },
    {            "--version",                                                     "Display version information" },
    { hide=true, "-V",                                                            "Display version information WITHOUT stopping build" },
    {            "--show-version",                                                "Display version information WITHOUT stopping build" },
    { hide=true, "-X",                                                            "Produce execution debug output" },
    {            "--debug",                                                       "Produce execution debug output" },
  })
  :nofiles()
