-- argument completion for bat 0.21
local arghelper = require("arghelper")

local file_matches   = clink.argmatcher():addarg(clink.filematches)
local dir_matches    = clink.argmatcher():addarg(clink.dirmatches)
local mode_parser    = clink.argmatcher():addarg("auto", "never", "always")
local when_parser    = clink.argmatcher():addarg("auto", "never", "always")
local when_parser_AN = clink.argmatcher():addarg("always", "never")

local cache_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-b"                                                                                                                                    },
    {            "--build",                                    "Initialize (or update) the syntax/theme cache by loading from the source directory"      },
    { hide=true, "-c"                                                                                                                                    },
    {            "--clear",                                    "Remove the cached syntax definitions and themes."                                        },
    {            "--source"           ..dir_matches, " <dir>", "Use a different directory to load syntaxes and themes from."                             },
    {            "--target"           ..dir_matches, " <dir>", "Use a different directory to store the cached syntax and theme set."                     },
    {            "--blank",                                    "Create completely new syntax and theme sets (instead of appending to the default sets)." },
    {            "--acknowledgements",                         "Build acknowledgements.bin."                                                             },
    { hide=true, "-h"                                                                                                                                    },
    {            "--help",                                     "Prints help information"                                                                 },
  })

local style_parser = clink.argmatcher()
  :_addexarg({
    { "default",         "enables recommended style components (default)."                                 },
    { "full",            "enables all available components."                                               },
    { "auto",            "same as 'default', unless the output is piped."                                  },
    { "plain",           "disables all available components."                                              },
    { "changes",         "show Git modification markers."                                                  },
    { "header",          "alias for 'header-filename'."                                                    },
    { "header-filename", "show filenames before the content."                                              },
    { "header-filesize", "show file sizes before the content."                                             },
    { "grid",            "vertical/horizontal lines to separate side bar and the header from the content." },
    { "rule",            "horizontal lines to delimit files."                                              },
    { "numbers",         "show line numbers in the side bar."                                              },
    { "snip",            "draw separation lines between distinct line ranges."                             },
  })


clink.argmatcher("bat")
  :_addexarg({
    { "cache"..cache_parser, "Modify the syntax-definition and theme cache" },
    { file_matches },
  })
  :_addexflags({
    { hide=true, "-A"                                                                                                                                              },
    {            "--show-all",                                              "Show non-printable characters like space, tab or newline."                            },
    { hide=true, "-p"                                                                                                                                              },
    {            "--plain",                                                 "Only show plain style, no decorations."                                               },
    { hide=true, "-l"                                                                                                                                              },
    {            "--language",                             " <language>",   "Explicitly set the language for syntax highlighting."                                 },
    { hide=true, "-H"                                                                                                                                              },
    {            "--highlight-line",                       " <N:M>",        "Highlight the specified line ranges with a different background color."               },
    {            "--file-name",                            " <name>",       "Specify the name to display for a file."                                              },
    { hide=true, "-d"                                                                                                                                              },
    {            "--diff",                                                  "Only show lines that have been added/removed/modified with respect to the Git index." },
    {            "--diff-context",                         " <N>",          "Include N lines of context around added/removed/modified lines when using '--diff'."  },
    {            "--tabs",                                 " <T>",          "Set the tab width to T spaces."                                                       },
    {            "--wrap"                ..mode_parser,    " <mode>",       "Specify the text-wrapping mode (*auto*, never, character)."                           },
    {            "--terminal-width",                       " <width>",      "Explicitly set the width of the terminal instead of determining it automatically."    },
    { hide=true, "-n"                                                                                                                                              },
    {            "--number",                                                "Only show line numbers, no other decorations."                                        },
    {            "--color"               ..when_parser,    " <when>",       "Specify when to use colored output."                                                  },
    {            "--italic-text"         ..when_parser_AN, " <when>",       "Specify when to use ANSI sequences for italic text in the output."                    },
    {            "--decorations"         ..when_parser,    " <when>",       "Specify when to use the decorations that have been specified via '--style'."          },
    { hide=true, "-f"                                                                                                                                              },
    {            "--force-colorization",                                    "Alias for '--decorations=always --color=always'."                                     },
    { hide=true, "-P"                                                                                                                                              },
    {            "--paging"              ..when_parser,    " <when>",       "Specify when to use the pager, or use '-P' to disable."                               },
    {            "--pager",                                " <command>",    "Determine which pager is used."                                                       },
    { hide=true, "-m"                                                                                                                                              },
    {            "--map-syntax",                           " <glob>",       "Map a glob pattern to an existing syntax name."                                       },
    {            "--ignored-suffix",                       " <suffix>",     "Ignore extension."                                                                    },
    {            "--theme",                                " <theme>",      "Set the theme for syntax highlighting."                                               },
    {            "--list-themes",                                           "Display a list of supported themes for syntax highlighting."                          },
    {            "--style"               ..style_parser,   " <components>", "Comma-separated list of style elements to display."                                   },
    { hide=true, "-r"                                                                                                                                              },
    {            "--line-range",                           " <N:M>",        "Only print the lines from N to M."                                                    },
    { hide=true, "-L"                                                                                                                                              },
    {            "--list-languages",                                        "Display a list of supported languages for syntax highlighting."                       },
    { hide=true, "-u"                                                                                                                                              },
    {            "--unbuffered",                                            "This option exists for POSIX-compliance reasons ('u' is for 'unbuffered')."           },
    {            "--diagnostic",                                            "Show diagnostic information for bug reports."                                         },
    {            "--acknowledgements",                                      "Show acknowledgements."                                                               },
    { hide=true, "-h"                                                                                                                                              },
    {            "--help",                                                  "Print help message."                                                                  },
    { hide=true, "-V"                                                                                                                                              },
    {            "--version",                                               "Show version information."                                                            },
  })
