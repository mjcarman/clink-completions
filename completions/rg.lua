-- argument completion for ripgrep v13.0
local arghelper = require("arghelper")

local file_matches       = clink.argmatcher():addarg(clink.filematches)
local num_matches        = clink.argmatcher():addarg()
local color_spec_matches = clink.argmatcher():addarg({fromhistory=true})
local encoding_matches   = clink.argmatcher():addarg({fromhistory=true})
local separator_matches  = clink.argmatcher():addarg({fromhistory=true})
local glob_matches       = clink.argmatcher():addarg({fromhistory=true})
local pattern_matches    = clink.argmatcher():addarg({fromhistory=true})
local replace_matches    = clink.argmatcher():addarg({fromhistory=true})
local type_matches       = clink.argmatcher():addarg({fromhistory=true})
local type_spec_matches  = clink.argmatcher():addarg({fromhistory=true})
local engine_parser      = clink.argmatcher():addarg({"default", "pcre2", "auto"})
local when_parser        = clink.argmatcher():addarg({"never", "auto", "always", "ansi"})
local sort_parser        = clink.argmatcher()
  :_addexarg({
      { "none",     "(Default) Do not sort results. Fastest. Can be multi-threaded."    },
      { "path",     "Sort by file path. Always single-threaded."                        },
      { "modified", "Sort by the last modified time on a file. Always single-threaded." },
      { "accessed", "Sort by the last accessed time on a file. Always single-threaded." },
      { "created",  "Sort by the creation time on a file. Always single-threaded."      },
  })


clink.argmatcher("rg")
:_addexflags({
    { hide=true, "-A"                        .. num_matches                                                                                           },
    {            "--after-context"           .. num_matches,        " <NUM>",              "Show NUM lines after each match."                         },
    { hide=true, "-B"                        .. num_matches                                                                                           },
    {            "--before-context"          .. num_matches,        " <NUM>",              "Show NUM lines before each match."                        },
    {            "--color"                   .. when_parser,        " <WHEN>",             "Controls when to use color."                              },
    {            "--colors"                  .. color_spec_matches, " <COLOR_SPEC>",       "Configure color settings and styles."                     },
    { hide=true, "-C"                        .. num_matches                                                                                           },
    {            "--context"                 .. num_matches,        " <NUM>",              "Show NUM lines before and after each match."              },
    {            "--context-separator"       .. separator_matches,  " <SEPARATOR>",        "Set the context separator string."                        },
    {            "--dfa-size-limit"          .. num_matches,        " <NUM+SUFFIX>",       "The upper size limit of the regex DFA."                   },
    { hide=true, "-E"                        .. encoding_matches                                                                                      },
    {            "--encoding"                .. encoding_matches,   " <ENCODING>",         "Specify the text encoding of files to search."            },
    {            "--engine"                  .. engine_parser,      " <ENGINE>",           "Specify which regexp engine to use."                      },
    {            "--field-context-separator" .. separator_matches,  " <SEPARATOR>",        "Set the field context separator."                         },
    {            "--field-match-separator"   .. separator_matches,  " <SEPARATOR>",        "Set the match separator."                                 },
    { hide=true, "-f"                        .. file_matches                                                                                          },
    {            "--file"                    .. file_matches,       " <PATTERNFILE>",      "Search for patterns from the given file."                 },
    { hide=true, "-g"                        .. glob_matches                                                                                          },
    {            "--glob"                    .. glob_matches,       " <GLOB>",             "Include or exclude files."                                },
    {            "--iglob",                                                                "Include or exclude files case insensitively."             },
    {            "--ignore-file"             .. file_matches,       " <PATH>",             "Specify additional ignore files."                         },
    { hide=true, "-M"                        .. num_matches                                                                                           },
    {            "--max-columns"             .. num_matches,        " <NUM>",              "Don't print lines longer than this limit."                },
    { hide=true, "-m"                        .. num_matches                                                                                           },
    {            "--max-count"               .. num_matches,        " <NUM>",              "Limit the number of matches."                             },
    {            "--max-depth"               .. num_matches,        " <NUM>",              "Descend at most NUM directories."                         },
    {            "--max-filesize"            .. num_matches,        " <NUM+SUFFIX>",       "Ignore files larger than NUM in size."                    },
    {            "--path-separator"          .. separator_matches,  " <SEPARATOR>",        "Set the path separator."                                  },
    {            "--pre"                     .. file_matches,       " <COMMAND>",          "search outputs of COMMAND FILE for each FILE"             },
    {            "--pre-glob"                .. glob_matches,       " <GLOB>",             "Include or exclude files from a preprocessing command."   },
    {            "--regex-size-limit"        .. num_matches,        " <NUM+SUFFIX>",       "The upper size limit of the compiled regex."              },
    { hide=true, "-e"                        .. pattern_matches                                                                                       },
    {            "--regexp"                  .. pattern_matches,    " <PATTERN>",          "A pattern to search for."                                 },
    { hide=true, "-r"                        .. replace_matches                                                                                       },
    {            "--replace"                 .. replace_matches,    " <REPLACEMENT_TEXT>", "Replace matches with the given text."                     },
    {            "--sort"                    .. sort_parser,        " <SORTBY>",           "Sort results in ascending order. Implies --threads=1."    },
    {            "--sortr"                   .. sort_parser,        " <SORTBY>",           "Sort results in descending order. Implies --threads=1."   },
    { hide=true, "-j"                        .. num_matches                                                                                           },
    {            "--threads"                 .. num_matches,        " <NUM>",              "The approximate number of threads to use."                },
    { hide=true, "-t"                        .. type_matches                                                                                          },
    {            "--type"                    .. type_matches,       " <TYPE>",             "Only search files matching TYPE."                         },
    {            "--type-add"                .. type_spec_matches,  " <TYPE_SPEC>",        "Add a new glob for a file type."                          },
    {            "--type-clear"              .. type_matches,       " <TYPE>",             "Clear globs for a file type."                             },
    { hide=true, "-T"                        .. type_matches                                                                                          },
    {            "--type-not"                .. type_matches,       " <TYPE>",             "Do not search files matching TYPE."                       },
    {            "--auto-hybrid-regex",                                                    "Dynamically use PCRE2 if necessary."                      },
    {            "--no-auto-hybrid-regex",                                                 "no-auto-hybrid-regex"                                     },
    {            "--binary",                                                               "Search binary files."                                     },
    {            "--no-binary",                                                            "no-binary"                                                },
    {            "--block-buffered",                                                       "Force block buffering."                                   },
    {            "--no-block-buffered",                                                    "no-block-buffered"                                        },
    { hide=true, "-b"                                                                                                                                 },
    {            "--byte-offset",                                                          "Print the 0-based byte offset for each matching line."    },
    { hide=true, "-s"                                                                                                                                 },
    {            "--case-sensitive",                                                       "Search case sensitively (default },."                     },
    {            "--column",                                                               "Show column numbers."                                     },
    {            "--no-column",                                                            "no-column"                                                },
    {            "--no-context-separator",                                                 "no-context-separator"                                     },
    { hide=true, "-c"                                                                                                                                 },
    {            "--count",                                                                "Only show the count of matching lines for each file."     },
    {            "--count-matches",                                                        "Only show the count of individual matches for each file." },
    {            "--crlf",                                                                 "Support CRLF line terminators (useful on Windows)."       },
    {            "--no-crlf",                                                              "no-crlf"                                                  },
    {            "--debug",                                                                "Show debug messages."                                     },
    {            "--trace",                                                                "trace"                                                    },
    {            "--no-encoding",                                                          "no-encoding"                                              },
    {            "--files",                                                                "Print each file that would be searched."                  },
    { hide=true, "-l"                                                                                                                                 },
    {            "--files-with-matches",                                                   "Print the paths with at least one match."                 },
    {            "--files-without-match",                                                  "Print the paths that contain zero matches."               },
    { hide=true, "-F"                                                                                                                                 },
    {            "--fixed-strings",                                                        "Treat the pattern as a literal string."                   },
    {            "--no-fixed-strings",                                                     "no-fixed-strings"                                         },
    { hide=true, "-L"                                                                                                                                 },
    {            "--follow",                                                               "Follow symbolic links."                                   },
    {            "--no-follow",                                                            "no-follow"                                                },
    {            "--glob-case-insensitive",                                                "Process all glob patterns case insensitively."            },
    {            "--no-glob-case-insensitive",                                             "no-glob-case-insensitive"                                 },
    {            "--heading",                                                              "Print matches grouped by each file."                      },
    {            "--no-heading",                                                           "Don't group matches by each file."                        },
    { hide=true, "-."                                                                                                                                 },
    {            "--hidden",                                                               "Search hidden files and directories."                     },
    {            "--no-hidden",                                                            "no-hidden"                                                },
    { hide=true, "-i"                                                                                                                                 },
    {            "--ignore-case",                                                          "Case insensitive search."                                 },
    {            "--ignore-file-case-insensitive",                                         "Process ignore files case insensitively."                 },
    {            "--no-ignore-file-case-insensitive",                                      "no-ignore-file-case-insensitive"                          },
    {            "--include-zero",                                                         "Include files with zero matches in summary"               },
    { hide=true, "-v"                                                                                                                                 },
    {            "--invert-match",                                                         "Invert matching."                                         },
    {            "--json",                                                                 "Show search results in a JSON Lines format."              },
    {            "--no-json",                                                              "no-json"                                                  },
    {            "--line-buffered",                                                        "Force line buffering."                                    },
    {            "--no-line-buffered",                                                     "no-line-buffered"                                         },
    { hide=true, "-n"                                                                                                                                 },
    {            "--line-number",                                                          "Show line numbers."                                       },
    { hide=true, "-N"                                                                                                                                 },
    {            "--no-line-number",                                                       "Suppress line numbers."                                   },
    { hide=true, "-x"                                                                                                                                 },
    {            "--line-regexp",                                                          "Only show matches surrounded by line boundaries."         },
    {            "--max-columns-preview",                                                  "Print a preview for lines exceeding the limit."           },
    {            "--no-max-columns-preview",                                               "no-max-columns-preview"                                   },
    {            "--mmap",                                                                 "Search using memory maps when possible."                  },
    {            "--no-mmap",                                                              "Never use memory maps."                                   },
    { hide=true, "-U"                                                                                                                                 },
    {            "--multiline",                                                            "Enable matching across multiple lines."                   },
    {            "--no-multiline",                                                         "no-multiline"                                             },
    {            "--multiline-dotall",                                                     "Make '.' match new lines when multiline is enabled."      },
    {            "--no-multiline-dotall",                                                  "no-multiline-dotall"                                      },
    {            "--no-config",                                                            "Never read configuration files."                          },
    {            "--no-ignore",                                                            "Don't respect ignore files."                              },
    {            "--ignore",                                                               "ignore"                                                   },
    {            "--no-ignore-dot",                                                        "Don't respect .ignore files."                             },
    {            "--ignore-dot",                                                           "ignore-dot"                                               },
    {            "--no-ignore-exclude",                                                    "Don't respect local exclusion files."                     },
    {            "--ignore-exclude",                                                       "ignore-exclude"                                           },
    {            "--no-ignore-files",                                                      "Don't respect --ignore-file arguments."                   },
    {            "--ignore-files",                                                         "ignore-files"                                             },
    {            "--no-ignore-global",                                                     "Don't respect global ignore files."                       },
    {            "--ignore-global",                                                        "ignore-global"                                            },
    {            "--no-ignore-messages",                                                   "Suppress gitignore parse error messages."                 },
    {            "--ignore-messages",                                                      "ignore-messages"                                          },
    {            "--no-ignore-parent",                                                     "Don't respect ignore files in parent directories."        },
    {            "--ignore-parent",                                                        "ignore-parent"                                            },
    {            "--no-ignore-vcs",                                                        "Don't respect VCS ignore files."                          },
    {            "--ignore-vcs",                                                           "ignore-vcs"                                               },
    {            "--no-messages",                                                          "Suppress some error messages."                            },
    {            "--messages",                                                             "messages"                                                 },
    {            "--no-pcre2-unicode",                                                     "Disable Unicode mode for PCRE2 matching."                 },
    {            "--pcre2-unicode",                                                        "pcre2-unicode"                                            },
    {            "--no-require-git",                                                       "Do not require a git repository to use gitignores."       },
    {            "--require-git",                                                          "require-git"                                              },
    {            "--no-unicode",                                                           "Disable Unicode mode."                                    },
    {            "--unicode",                                                              "unicode"                                                  },
    { hide=true, "-0"                                                                                                                                 },
    {            "--null",                                                                 "Print a NUL byte after file paths."                       },
    {            "--null-data",                                                            "Use NUL as a line terminator instead of \n."              },
    {            "--one-file-system",                                                      "Do not descend into directories on other file systems."   },
    {            "--no-one-file-system",                                                   "no-one-file-system"                                       },
    { hide=true, "-o"                                                                                                                                 },
    {            "--only-matching",                                                        "Print only matched parts of a line."                      },
    {            "--passthru",                                                             "Print both matching and non-matching lines."              },
    { hide=true, "-P"                                                                                                                                 },
    {            "--pcre2",                                                                "Enable PCRE2 matching."                                   },
    {            "--no-pcre2",                                                             "no-pcre2"                                                 },
    {            "--pcre2-version",                                                        "Print the version of PCRE2 that ripgrep uses."            },
    {            "--no-pre",                                                               "no-pre"                                                   },
    { hide=true, "-p"                                                                                                                                 },
    {            "--pretty",                                                               "Alias for --color always --heading --line-number."        },
    { hide=true, "-q"                                                                                                                                 },
    {            "--quiet",                                                                "Do not print anything to stdout."                         },
    { hide=true, "-z"                                                                                                                                 },
    {            "--search-zip",                                                           "Search in compressed files."                              },
    {            "--no-search-zip",                                                        "no-search-zip"                                            },
    { hide=true, "-S"                                                                                                                                 },
    {            "--smart-case",                                                           "Smart case search."                                       },
    {            "--sort-files",                                                           "DEPRECATED"                                               },
    {            "--no-sort-files",                                                        "no-sort-files"                                            },
    {            "--stats",                                                                "Print statistics about this ripgrep search."              },
    {            "--no-stats",                                                             "no-stats"                                                 },
    { hide=true, "-a"                                                                                                                                 },
    {            "--text",                                                                 "Search binary files as if they were text."                },
    {            "--no-text",                                                              "no-text"                                                  },
    {            "--trim",                                                                 "Trim prefixed whitespace from matches."                   },
    {            "--no-trim",                                                              "no-trim"                                                  },
    {            "--type-list",                                                            "Show all supported file types."                           },
    { hide=true, "-u"                                                                                                                                 },
    {            "--unrestricted",                                                         "Reduce the level of 'smart' searching."                   },
    {            "--vimgrep",                                                              "Show results in vim compatible format."                   },
    { hide=true, "-H"                                                                                                                                 },
    {            "--with-filename",                                                        "Print the file path with the matched lines."              },
    { hide=true, "-I"                                                                                                                                 },
    {            "--no-filename",                                                          "Never print the file path with the matched lines."        },
    { hide=true, "-w"                                                                                                                                 },
    {            "--word-regexp",                                                          "Only show matches surrounded by word boundaries."         },
    { hide=true, "-h"                                                                                                                                 },
    {            "--help",                                                                 "Prints help information. Use --help for more details."    },
    { hide=true, "-V"                                                                                                                                 },
    {            "--version",                                                              "Prints version information"                               },
  })
