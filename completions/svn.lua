-- argument completion for svn
local arghelper = require("arghelper")

local file_matches       = clink.argmatcher():addarg(clink.filematches)
local dir_matches        = clink.argmatcher():addarg(clink.dirmatches)
local confspec_matches   = clink.argmatcher():addarg({fromhistory=true})
local depth_matches      = clink.argmatcher():addarg({fromhistory=true})
local message_matches    = clink.argmatcher():addarg({fromhistory=true})
local diff_matches       = clink.argmatcher():addarg({fromhistory=true})
local edit_matches       = clink.argmatcher():addarg({fromhistory=true})
local revprop_matches    = clink.argmatcher():addarg({fromhistory=true})
local encoding_matches   = clink.argmatcher():addarg({fromhistory=true})
local search_matches     = clink.argmatcher():addarg({fromhistory=true})
local username_matches   = clink.argmatcher():addarg({fromhistory=true})
local password_matches   = clink.argmatcher():addarg()
local revision_matches   = clink.argmatcher():addarg()
local changelist_matches = clink.argmatcher():addarg()
local limit_matches      = clink.argmatcher():addarg()
local strip_matches      = clink.argmatcher():addarg()
local depth_matches      = clink.argmatcher():addarg("empty", "files", "immediates", "infinity")
local eol_matches        = clink.argmatcher():addarg("LF", "CR", "CRLF")
local showrev_matches    = clink.argmatcher():addarg("merged", "eligible")

local extension_matches  = clink.argmatcher()
  :_addexflags({
    -- flags for internal diff and blame
    { hide=true, "-u",                            "Show 3 lines of unified context" },
    {            "--unified",                     "Show 3 lines of unified context" },
    { hide=true, "-b",                            "Ignore changes in amount of white space" },
    {            "--ignore-space-change",         "Ignore changes in amount of white space" },
    { hide=true, "-w",                            "Ignore all white space" },
    {            "--ignore-all-space",            "Ignore all white space" },
    {            "--ignore-eol-style",            "Ignore changes in EOL style" },
    { hide=true, "-U",                    " ARG", "Show ARG lines of context" },
    {            "--context",             " ARG", "Show ARG lines of context" },
    { hide=true, "-p",                            "Show C function name" },
    {            "--show-c-function",             "Show C function name" },
    -- flags for external diff and blame
    {fromhistory=true}
  })


local item_matches = clink.argmatcher()
  :_addexarg({
    { "kind",                  "node kind of TARGET" },
    { "url",                   "URL of TARGET in the repository" },
    { "relative-url",          "repository-relative URL of TARGET" },
    { "repos-root-url",        "root URL of repository" },
    { "repos-uuid",            "UUID of repository" },
    { "repos-size",            "for files, the size of TARGET in the repository" },
    { "revision",              "specified or implied revision" },
    { "last-changed-revision", "last change of TARGET at or before 'revision'" },
    { "last-changed-date",     "date of 'last-changed-revision'" },
    { "last-changed-author",   "author of 'last-changed-revision'" },
    { "wc-root",               "root of TARGET's working copy" },
    { "schedule",              "'normal','add','delete','replace'" },
    { "depth",                 "checkout depth of TARGET in WC" },
  })


local accept_matches = clink.argmatcher()
  :addarg(
    "p",  "postpone",
          "working",
          "base",
    "mc", "mine-conflict",
    "tc", "theirs-conflict",
    "mf", "mine-full",
    "tf", "theirs-full",
    "e",  "edit",
    "l",  "launch",
    "r",  "recommended")


----------------------------------------------------------------------------------------------------

function add_global_options(parser)
  parser
    :_addexflags({
      { "--username"                    .. username_matches,   " ARG", "specify a username ARG" },
      { "--password"                    .. password_matches,   " ARG", "specify a password ARG" },
      { "--no-auth-cache",                                             "do not cache authentication tokens" },
      { "--non-interactive",                                           "do no interactive prompting" },
      { "--trust-server-cert",                                         "accept SSL server certificates from unknown authorities" },
      { "--config-dir"                  .. dir_matches,        " ARG", "read user configuration files from directory ARG" },
      { "--config-option"               .. confspec_matches,   " ARG", "set user configuration option" },
    })
end


local add_parser = clink.argmatcher()
  :_addexflags({
    {            "--targets"            .. file_matches,       " ARG", "pass contents of file ARG as additional args" },
    { hide=true, "-N",                                                 "obsolete; same as --depth=empty" },
    { hide=true, "--non-recursive",                                    "obsolete; same as --depth=empty" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    {            "--force",                                            "ignore already versioned paths" },
    {            "--no-ignore",                                        "disregard default and svn:ignore and svn:global-ignores property ignores" },
    {            "--auto-props",                                       "enable automatic properties" },
    {            "--no-auto-props",                                    "disable automatic properties" },
    {            "--parents",                                          "add intermediate parents" },
  })
add_global_options(add_parser)


local blame_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    { hide=true, "-v",                                                 "print extra information" },
    {            "--verbose",                                          "print extra information" },
    { hide=true, "-g",                                                 "use/display additional information from merge history" },
    {            "--use-merge-history",                                "use/display additional information from merge history" },
    {            "--incremental",                                      "give output suitable for concatenation" },
    {            "--xml",                                              "output in XML" },
    { hide=true, "-x"                   .. extension_matches,  " ARG", "differencing options" },
    {            "--extensions"         .. extension_matches,  " ARG", "differencing options" },
    {            "--force",                                            "force operation to run" },
  })
add_global_options(blame_parser)


local cat_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--ignore-keywords",                                  "don't expand keywords" },
  })
add_global_options(cat_parser)


local changelist_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    { hide=true, "-R",                                                 "descend recursively, same as --depth=infinity" },
    { hide=true, "--recursive",                                        "descend recursively, same as --depth=infinity" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    {            "--remove",                                           "remove changelist association" },
    {            "--targets"            .. file_matches,       " ARG", "pass contents of file ARG as additional args" },
    { hide=true, "--cl"                 .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--changelist"         .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
  })
add_global_options(changelist_parser)


local checkout_parser = clink.argmatcher()
  :_addexflags({
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    { hide=true, "-N",                                                 "obsolete; same as --depth=empty" },
    { hide=true, "--non-recursive",                                    "obsolete; same as --depth=empty" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    {            "--force",                                            "force operation to run" },
    {            "--ignore-externals",                                 "ignore externals definitions" },
  })
add_global_options(checkout_parser)


local cleanup_parser = clink.argmatcher()
  :_addexflags({
    {            "--remove-unversioned",                               "remove unversioned items" },
    {            "--remove-ignored",                                   "remove ignored items" },
    {            "--vacuum-pristines",                                 "remove unreferenced pristines from .svn directory" },
    {            "--include-externals",                                "also operate on externals defined by svn:externals properties" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    { hide=true, "--diff3-cmd",                                " ARG", "deprecated and ignored" },
  })
add_global_options(cleanup_parser)


local commit_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    { hide=true, "-N",                                                 "obsolete; same as --depth=empty" },
    { hide=true, "--non-recursive",                                    "obsolete; same as --depth=empty" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    {            "--targets"            .. file_matches,       " ARG", "pass contents of file ARG as additional args" },
    {            "--no-unlock",                                        "pass contents of file ARG as additional args" },
    { hide=true, "-m"                   .. message_matches,    " ARG", "specify log message ARG" },
    {            "--message"            .. message_matches,    " ARG", "specify log message ARG" },
    { hide=true, "-F"                   .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--file"               .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--force-log",                                        "force validity of log message source" },
    {            "--editor-cmd"         .. edit_matches,       " ARG", "use ARG as external editor" },
    {            "--encoding"           .. encoding_matches,   " ARG", "treat value as being in charset encoding ARG" },
    {            "--with-revprop"       .. revprop_matches,    " ARG", "set revision property ARG in new revision using the name[=value] format" },
    { hide=true, "--cl"                 .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--changelist"         .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--keep-changelists",                                 "don't delete changelists after commit" },
    {            "--include-externals",                                "also operate on externals defined by svn:externals properties" },
  })
add_global_options(commit_parser)


local copy_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    {            "--ignore-externals",                                 "ignore externals definitions" },
    {            "--parents",                                          "make intermediate directories" },
    { hide=true, "-m"                   .. message_matches,    " ARG", "specify log message ARG" },
    {            "--message"            .. message_matches,    " ARG", "specify log message ARG" },
    { hide=true, "-F"                   .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--file"               .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--force-log",                                        "force validity of log message source" },
    {            "--editor-cmd"         .. edit_matches,       " ARG", "use ARG as external editor" },
    {            "--encoding"           .. encoding_matches,   " ARG", "treat value as being in charset encoding ARG" },
    {            "--with-revprop"       .. revprop_matches,    " ARG", "set revision property ARG in new revision using the name[=value] format" },
    {            "--pin-externals",                                    "pin externals with no explicit revision to their current revision" },
  })
add_global_options(copy_parser)


local delete_parser = clink.argmatcher()
  :_addexflags({
    {            "--force",                                            "force operation to run" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    {            "--targets"            .. file_matches,       " ARG", "pass contents of file ARG as additional args" },
    { hide=true, "-m"                   .. message_matches,    " ARG", "specify log message ARG" },
    {            "--message"            .. message_matches,    " ARG", "specify log message ARG" },
    { hide=true, "-F"                   .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--file"               .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--force-log",                                        "force validity of log message source" },
    {            "--editor-cmd"         .. edit_matches,       " ARG", "use ARG as external editor" },
    {            "--encoding"           .. encoding_matches,   " ARG", "treat value as being in charset encoding ARG" },
    {            "--with-revprop"       .. revprop_matches,    " ARG", "set revision property ARG in new revision using the name[=value] format" },
    {            "--keep-local",                                       "keep path in working copy" },
  })
add_global_options(delete_parser)


local diff_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    { hide=true, "-c"                   .. revision_matches,   " ARG", "the change made by revision ARG (like -r ARG-1:ARG)" },
    {            "--change"             .. revision_matches,   " ARG", "the change made by revision ARG (like -r ARG-1:ARG)" },
    {            "--old"                .. revision_matches,   " ARG", "use ARGas the older target" },
    {            "--new"                .. revision_matches,   " ARG", "use ARGas the newer target" },
    { hide=true, "-N",                                                 "obsolete; same as --depth=empty" },
    { hide=true, "--non-recursive",                                    "obsolete; same as --depth=empty" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    {            "--diff-cmd"           .. diff_matches,       " ARG", "use ARG as diff cmd" },
    {            "--internal-diff",                                    "override diff-cmd specified in config file" },
    { hide=true, "-x"                   .. extension_matches,  " ARG", "differencing options" },
    {            "--extensions"         .. extension_matches,  " ARG", "differencing options" },
    {            "--no-diff-added",                                    "do not print differences for added files" },
    {            "--no-diff-deleted",                                  "do not print differences for deleted files" },
    {            "--ignore-properties",                                "ignore properties during the operation" },
    {            "--properties-only",                                  "show only properties during the operation" },
    {            "--show-copies-as-adds",                              "don't diff copied or moved files with their source" },
    {            "--notice-ancestry",                                   "diff unrelated nodes as delete and add" },
    {            "--summarize",                                         "show a summary of the results" },
    { hide=true, "--cl"                 .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--changelist"         .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--force",                                            "force operation to run" },
    {            "--xml",                                              "output in XML" },
    {            "--git",                                              "use git's extended diff format" },
    {            "--patch-compatible",                                  "generate diff suitable for generic third-party patch tools" },
  })
add_global_options(diff_parser)


local export_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    { hide=true, "-N",                                                 "obsolete; same as --depth=empty" },
    { hide=true, "--non-recursive",                                    "obsolete; same as --depth=empty" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    {            "--force",                                            "force operation to run" },
    {            "--native-eol"         .. eol_matches,        " ARG", "use a different EOL marker than the standard system marker" },
    {            "--ignore-keywords",                                  "don't expand keywords" },
    {            "--ignore-externals",                                 "ignore externals definitions" },
  })
add_global_options(export_parser)


local import_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    { hide=true, "-N",                                                 "obsolete; same as --depth=empty" },
    { hide=true, "--non-recursive",                                    "obsolete; same as --depth=empty" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    {            "--auto-props",                                       "enable automatic properties" },
    {            "--no-auto-props",                                    "disable automatic properties" },
    {            "--force",                                            "force operation to run" },
    { hide=true, "-m"                   .. message_matches,    " ARG", "specify log message ARG" },
    {            "--message"            .. message_matches,    " ARG", "specify log message ARG" },
    { hide=true, "-F"                   .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--file"               .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--force-log",                                        "force validity of log message source" },
    {            "--editor-cmd"         .. edit_matches,       " ARG", "use ARG as external editor" },
    {            "--encoding"           .. encoding_matches,   " ARG", "treat value as being in charset encoding ARG" },
    {            "--with-revprop"       .. revprop_matches,    " ARG", "set revision property ARG in new revision using the name[=value] format" },
    {            "--no-ignore",                                        "disregard default and svn:ignore and svn:global-ignores property ignores" },
  })
add_global_options(import_parser)


local info_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    { hide=true, "-R",                                                 "descend recursively, same as --depth=infinity" },
    {            "--recursive",                                        "descend recursively, same as --depth=infinity" },
    { hide=true, "-H",                                                 "show file sizes with base-2 unit suffixes" },
    {            "--human-readable",                                   "show file sizes with base-2 unit suffixes" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    {            "--targets"            .. file_matches,       " ARG", "pass contents of file ARG as additional args" },
    {            "--incremental",                                       "give output suitable for concatenation" },
    {            "--xml",                                              "output in XML" },
    { hide=true, "--cl"                 .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--changelist"         .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--include-externals",                                "also operate on externals defined by svn:externals properties" },
    {            "--show-item"          .. item_matches,       " ARG", "print only the item identified by ARG" },
    {            "--no-newline" ,                                      "do not output the trailing newline" },
  })
add_global_options(info_parser)


local list_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    { hide=true, "-v",                                                 "print extra information" },
    {            "--verbose" ,                                         "print extra information" },
    { hide=true, "-R",                                                 "descend recursively, same as --depth=infinity" },
    {            "--recursive",                                        "descend recursively, same as --depth=infinity" },
    { hide=true, "-H",                                                 "show file sizes with base-2 unit suffixes" },
    {            "--human-readable",                                   "show file sizes with base-2 unit suffixes" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    {            "--incremental",                                      "give output suitable for concatenation" },
    {            "--xml",                                              "output in XML" },
    {            "--include-externals",                                "also operate on externals defined by svn:externals properties" },
    {            "--search"              .. search_matches,    " ARG", "use ARG as search pattern" },
  })
add_global_options(list_parser)


local lock_parser = clink.argmatcher()
  :_addexflags({
    {            "--targets"            .. file_matches,       " ARG", "pass contents of file ARG as additional args" },
    { hide=true, "-m"                   .. message_matches,    " ARG", "specify lock comment ARG" },
    {            "--message"            .. message_matches,    " ARG", "specify lock comment ARG" },
    { hide=true, "-F"                   .. file_matches,       " ARG", "read lock comment from file ARG" },
    {            "--file"               .. file_matches,       " ARG", "read lock comment from file ARG" },
    {            "--force-log",                                        "force validity of comment source" },
    {            "--encoding"           .. encoding_matches,   " ARG", "treat value as being in charset encoding ARG" },
    {            "--force",                                            "steal locks" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
  })
add_global_options(lock_parser)


local log_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    { hide=true, "-c"                   .. revision_matches,   " ARG", "the change made by revision ARG (like -r ARG-1:ARG)" },
    {            "--change"             .. revision_matches,   " ARG", "the change made by revision ARG (like -r ARG-1:ARG)" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    { hide=true, "-v",                                                 "also print all affected paths" },
    {            "--verbose",                                          "also print all affected paths" },
    { hide=true, "-g",                                                 "use/display additional information from merge history" },
    {            "--use-merge-history",                                "use/display additional information from merge history" },
    {            "--targets"            .. file_matches,       " ARG", "pass contents of file ARG as additional args" },
    {            "--stop-on-copy",                                     "do not cross copies while traversing history" },
    {            "--incremental",                                      "give output suitable for concatenation" },
    {            "--xml",                                              "output in XML" },
    {            "-l"                   .. limit_matches,      " ARG", "maximum number of log entries" },
    {            "--limit"              .. limit_matches,      " ARG", "maximum number of log entries" },
    {            "--with-all-revprops",                                "retrieve all revision properties" },
    {            "--with-no-revprops",                                 "retrieve no revision properties" },
    {            "--with-revprop"       .. revprop_matches,    " ARG", "retrieve revision property ARG" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    {            "--diff",                                             "produce diff output" },
    {            "--diff-cmd"           .. diff_matches,       " ARG", "use ARG as diff cmd" },
    {            "--internal-diff",                                    "override diff-cmd specified in config file" },
    { hide=true, "-x"                   .. extension_matches,  " ARG", "differencing options" },
    {            "--extensions"         .. extension_matches,  " ARG", "differencing options" },
    {            "--search"             .. search_matches,     " ARG", "use ARG as search pattern" },
    {            "--search-and"         .. search_matches,     " ARG", "combine ARG with the previous search pattern" },
  })
add_global_options(log_parser)


local merge_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    { hide=true, "-c"                   .. revision_matches,   " ARG", "the change made by revision ARG (like -r ARG-1:ARG)" },
    {            "--change"             .. revision_matches,   " ARG", "the change made by revision ARG (like -r ARG-1:ARG)" },
    { hide=true, "-N",                                                 "obsolete; same as --depth=empty" },
    { hide=true, "--non-recursive",                                    "obsolete; same as --depth=empty" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    {            "--force",                                            "ignore already versioned paths" },
    {            "--dry-run",                                          "try operation but make no changes" },
    {            "--diff3-cmd"          .. diff_matches,       " ARG", "use ARG as merge cmd" },
    {            "--record-only",                                      "merge only mergeinfo differences" },
    { hide=true, "-x"                   .. extension_matches,  " ARG", "differencing options" },
    {            "--extensions"         .. extension_matches,  " ARG", "differencing options" },
    {            "--ignore-ancestry",                                  "disable merge tracking; diff nodes as if related" },
    {            "--accept"             .. accept_matches,     " ARG", "specify automatic conflict resolution action" },
    { hide=true, "--reintegrate",                                      "deprecated" },
    {            "--allow-mixed-revisions",                            "allow operation on mixed-revision working copy" },
    { hide=true, "-v",                                                 "print extra information" },
    {            "--verbose",                                          "print extra information" },
  })
add_global_options(merge_parser)


local mergeinfo_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    { hide=true, "-R",                                                 "descend recursively, same as --depth=infinity" },
    { hide=true, "--recursive",                                        "descend recursively, same as --depth=infinity" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    { hide=true, "-v",                                                 "print extra information" },
    {            "--verbose",                                          "print extra information" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    {            "--show-revs"          .. showrev_matches,    " ARG", "specify which collection of revisions to display" },
    {            "--log",                                              "show revision log message, author and date" },
    {            "--incremental",                                      "give output suitable for concatenation" },
  })
add_global_options(mergeinfo_parser)


local mkdir_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    {            "--parents",                                          "make intermediate parents" },
    { hide=true, "-m"                   .. message_matches,    " ARG", "specify log message ARG" },
    {            "--message"            .. message_matches,    " ARG", "specify log message ARG" },
    { hide=true, "-F"                   .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--file"               .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--force-log",                                        "force validity of log message source" },
    {            "--editor-cmd"         .. edit_matches,       " ARG", "use ARG as external editor" },
    {            "--encoding"           .. encoding_matches,   " ARG", "treat value as being in charset encoding ARG" },
    {            "--with-revprop"       .. revprop_matches,    " ARG", "set revision property ARG in new revision using the name[=value] format" },
  })
add_global_options(mkdir_parser)


local move_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    {            "--force",                                            "force operation to run" },
    {            "--parents",                                          "make intermediate parents" },
    {            "--allow-mixed-revisions",                            "allow operation on mixed-revision working copy" },
    { hide=true, "-m"                   .. message_matches,    " ARG", "specify log message ARG" },
    {            "--message"            .. message_matches,    " ARG", "specify log message ARG" },
    { hide=true, "-F"                   .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--file"               .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--force-log",                                        "force validity of log message source" },
    {            "--editor-cmd"         .. edit_matches,       " ARG", "use ARG as external editor" },
    {            "--encoding"           .. encoding_matches,   " ARG", "treat value as being in charset encoding ARG" },
    {            "--with-revprop"       .. revprop_matches,    " ARG", "set revision property ARG in new revision using the name[=value] format" },
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
  })
add_global_options(move_parser)


local patch_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    {            "--dry-run",                                          "try operation but make no changes" },
    {            "--strip"              .. strip_matches,      " ARG", "number of leading path components to strip from paths parsed from the patch file" },
    {            "--reverse-diff",                                     "apply the unidiff in reverse" },
    {            "--ignore-whitespace",                                "ignore whitespace during pattern matching" },
  })
add_global_options(patch_parser)


local propdel_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    { hide=true, "-R",                                                 "descend recursively, same as --depth=infinity" },
    { hide=true, "--recursive",                                        "descend recursively, same as --depth=infinity" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revprop"            .. revprop_matches,    " ARG", "operate on a revision property (use with -r)" },
    { hide=true, "--cl"                 .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--changelist"         .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
  })
add_global_options(propdel_parser)


local propedit_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revprop"            .. revprop_matches,    " ARG", "operate on a revision property (use with -r)" },
    { hide=true, "-m"                   .. message_matches,    " ARG", "specify log message ARG" },
    {            "--message"            .. message_matches,    " ARG", "specify log message ARG" },
    { hide=true, "-F"                   .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--file"               .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--force-log",                                        "force validity of log message source" },
    {            "--editor-cmd"         .. edit_matches,       " ARG", "use ARG as external editor" },
    {            "--encoding"           .. encoding_matches,   " ARG", "treat value as being in charset encoding ARG" },
    {            "--with-revprop"       .. revprop_matches,    " ARG", "set revision property ARG in new revision using the name[=value] format" },
    {            "--force",                                            "force operation to run" },
  })
add_global_options(propedit_parser)


local propget_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-v",                                                 "print extra information" },
    {            "--verbose",                                          "print extra information" },
    { hide=true, "-R",                                                 "descend recursively, same as --depth=infinity" },
    { hide=true, "--recursive",                                        "descend recursively, same as --depth=infinity" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revprop"            .. revprop_matches,    " ARG", "operate on a revision property (use with -r)" },
    { hide=true, "--strict",                                           "(deprecated; use --no-newline)" },
    { hide=true, "--no-newline",                                       "do not output the trailing newline" },
    {            "--xml",                                              "output in XML" },
    { hide=true, "--cl"                 .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--changelist"         .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--show-inherited-props",                             "retrieve properties set on parents of the target" },
  })
add_global_options(propget_parser)

local proplist_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-v",                                                 "print extra information" },
    {            "--verbose",                                          "print extra information" },
    { hide=true, "-R",                                                 "descend recursively, same as --depth=infinity" },
    { hide=true, "--recursive",                                        "descend recursively, same as --depth=infinity" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    { hide=true, "-q",                                                 "don't print the path" },
    {            "--quiet",                                            "don't print the path" },
    {            "--revprop"            .. revprop_matches,    " ARG", "operate on a revision property (use with -r)" },
    {            "--xml",                                              "output in XML" },
    { hide=true, "--cl"                 .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--changelist"         .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--show-inherited-props",                             "retrieve properties set on parents of the target" },
  })
add_global_options(proplist_parser)


local propset_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-F"                   .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--file"               .. file_matches,       " ARG", "read log message from file ARG" },
    {            "--encoding"           .. encoding_matches,   " ARG", "treat value as being in charset encoding ARG" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--targets"            .. file_matches,       " ARG", "pass contents of file ARG as additional args" },
    { hide=true, "-R",                                                 "descend recursively, same as --depth=infinity" },
    { hide=true, "--recursive",                                        "descend recursively, same as --depth=infinity" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    {            "--revprop"            .. revprop_matches,    " ARG", "operate on a revision property (use with -r)" },
    {            "--force",                                            "force operation to run" },
    { hide=true, "--cl"                 .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--changelist"         .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
  })
add_global_options(propset_parser)


local relocate_parser = clink.argmatcher()
  :_addexflags({
    {            "--ignore-externals",                                 "ignore externals definitions" },
  })
add_global_options(relocate_parser)


local resolve_parser = clink.argmatcher()
  :_addexflags({
    {            "--targets"            .. file_matches,       " ARG", "pass contents of file ARG as additional args" },
    { hide=true, "-R",                                                 "descend recursively, same as --depth=infinity" },
    { hide=true, "--recursive",                                        "descend recursively, same as --depth=infinity" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    {            "--accept"             .. accept_matches,     " ARG", "specify automatic conflict resolution action" },
  })
add_global_options(resolve_parser)


local resolved_parser = clink.argmatcher()
  :_addexflags({
    {            "--targets"            .. file_matches,       " ARG", "pass contents of file ARG as additional args" },
    { hide=true, "-R",                                                 "descend recursively, same as --depth=infinity" },
    { hide=true, "--recursive",                                        "descend recursively, same as --depth=infinity" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
  })
add_global_options(resolved_parser)


local revert_parser = clink.argmatcher()
  :_addexflags({
    {            "--targets"            .. file_matches,       " ARG", "pass contents of file ARG as additional args" },
    { hide=true, "-R",                                                 "descend recursively, same as --depth=infinity" },
    { hide=true, "--recursive",                                        "descend recursively, same as --depth=infinity" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    { hide=true, "--cl"                 .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--changelist"         .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--remove-added",                                     "reverting an added item will remove it from disk" },
  })
add_global_options(revert_parser)


local status_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-u",                                                 "display update information" },
    { hide=true, "--show-updates",                                     "display update information" },
    { hide=true, "-v",                                                 "print extra information" },
    {            "--verbose" ,                                         "print extra information" },
    { hide=true, "-N",                                                 "obsolete; same as --depth=empty" },
    { hide=true, "--non-recursive",                                    "obsolete; same as --depth=empty" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    { hide=true, "-q",                                                 "don't print unversioned items" },
    {            "--quiet",                                            "don't print unversioned items" },
    {            "--no-ignore",                                        "disregard default and svn:ignore and svn:global-ignores property ignores" },
    {            "--incremental",                                      "give output suitable for concatenation" },
    {            "--xml",                                              "output in XML" },
    {            "--ignore-externals",                                 "ignore externals definitions" },
    { hide=true, "--cl"                 .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--changelist"         .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
  })
add_global_options(status_parser)


local switch_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    { hide=true, "-N",                                                 "obsolete; same as --depth=empty" },
    { hide=true, "--non-recursive",                                    "obsolete; same as --depth=empty" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    {            "--set-depth"          .. depth_matches,      " ARG", "set new working copy depth to ARG" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    {            "--diff3-cmd"          .. diff_matches,       " ARG", "use ARG as merge cmd" },
    {            "--ignore-externals",                                 "ignore externals definitions" },
    {            "--ignore-ancestry",                                  "allow switching to a node with no common ancestor" },
    {            "--force",                                            "handle unversioned obstructions as changes" },
    {            "--accept"             .. accept_matches,     " ARG", "specify automatic conflict resolution action" },
    { hide=true, "--relocate",                                         "deprecated; use 'svn relocate'" },
  })
add_global_options(switch_parser)


local unlock_parser = clink.argmatcher()
  :_addexflags({
    {            "--targets"            .. file_matches,       " ARG", "pass contents of file ARG as additional args" },
    {            "--force",                                            "break locks" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
  })
add_global_options(unlock_parser)


local update_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-r"                   .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    {            "--revision"           .. revision_matches,   " ARG", "revision (ARG; some commands also take ARG1:ARG2 range)" },
    { hide=true, "-N",                                                 "obsolete; same as --depth=empty" },
    { hide=true, "--non-recursive",                                    "obsolete; same as --depth=empty" },
    {            "--depth"              .. depth_matches,      " ARG", "limit operation by depth ARG" },
    {            "--set-depth"          .. depth_matches,      " ARG", "set new working copy depth to ARG" },
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
    {            "--diff3-cmd"          .. diff_matches,       " ARG", "use ARG as merge cmd" },
    {            "--force",                                            "handle unversioned obstructions as changes" },
    {            "--ignore-externals",                                 "ignore externals definitions" },
    { hide=true, "--cl"                 .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--changelist"         .. changelist_matches, " ARG", "operate only on members of changelist ARG" },
    {            "--editor-cmd"         .. edit_matches,       " ARG", "use ARG as external editor" },
    {            "--accept"             .. accept_matches,     " ARG", "specify automatic conflict resolution action" },
    {            "--parents",                                          "make intermediate parents" },
    {            "--adds-as-modification",                             "Local additions are merged with incoming additions instead of causing a tree conflict" },
  })
add_global_options(update_parser)


local upgrade_parser = clink.argmatcher()
  :_addexflags({
    { hide=true, "-q",                                                 "print nothing, or only summary information" },
    {            "--quiet",                                            "print nothing, or only summary information" },
  })
add_global_options(upgrade_parser)


local help_parser = clink.argmatcher()
  :addarg(
    "add",
    "blame", "praise", "annotate", "ann",
    "cat",
    "changelist", "cl",
    "checkout",   "co",
    "cleanup",
    "commit",     "ci",
    "copy",       "cp",
    "delete",     "del",
    "remove",     "rm",
    "diff",       "di",
    "export",
    "help",       "h",
    "import",
    "info",
    "list",       "ls",
    "lock",
    "log",
    "merge",
    "mkdir",
    "move",       "mv",
    "patch",
    "propdel",    "pd", "pdel",
    "propedit",   "pe", "pedit",
    "propget",    "pg", "pget",
    "proplist",   "pl", "plist",
    "propset",    "ps", "pset",
    "relocate",
    "resolve",
    "resolved",
    "revert",
    "status",     "st", "stat",
    "switch",     "sw",
    "unlock",
    "update",     "up",
    "upgrade")
  :nofiles()


clink.argmatcher("svn")
  :_addexarg({
    { "add"        .. add_parser,        "Add files, directories, or symbolic links." },
    { "blame"      .. blame_parser,      "Show author and revision information inline for the specified files or URLs." },
    { "cat"        .. cat_parser,        "Output the contents of the specified files or URLs." },
    { "changelist" .. changelist_parser, "Associate (or deassociate) local paths with a changelist." },
    { "checkout"   .. checkout_parser,   "Check out a working copy from a repository." },
    { "remove"     .. delete_parser,     "Delete an item from a working copy or the repository." },
    { "cleanup"    .. cleanup_parser,    "Recursively clean up the working copy." },
    { "commit"     .. commit_parser,     "Send changes from your working copy to the repository." },
    { "copy"       .. copy_parser,       "Copy a file or directory in a working copy or in the repository." },
    { "diff"       .. diff_parser,       "This displays the differences between two revisions or paths." },
    { "export"     .. export_parser,     "Export a clean directory tree." },
    { "help"       .. help_parser,       "Help!" },
    { "import"     .. import_parser,     "Commit an unversioned file or tree into the repository." },
    { "info"       .. info_parser,       "Display information about a local or remote item." },
    { "list"       .. list_parser,       "List directory entries in the repository." },
    { "lock"       .. lock_parser,       "Lock working copy paths or URLs in the repository so that no other user can commit changes to them" },
    { "log"        .. log_parser,        "Display commit log messages." },
    { "merge"      .. merge_parser,      "Apply the differences between two sources to a working copy path." },
    { "mergeinfo"  .. mergeinfo_parser,  "Query merge-related information." },
    { "mkdir"      .. mkdir_parser,      "Create a new directory under version control." },
    { "move"       .. move_parser,       "Move a file or directory." },
    { "patch"      .. patch_parser,      "Apply changes represented in a unidiff patch to the working copy." },
    { "propdel"    .. propdel_parser,    "Remove a property from an item." },
    { "propedit"   .. propedit_parser,   "Edit the property of one or more items under version control." },
    { "propget"    .. propget_parser,    "Print the value of a property." },
    { "proplist"   .. proplist_parser,   "List all properties." },
    { "propset"    .. propset_parser,    "Set PROPNAME to PROPVAL on files, directories, or revisions." },
    { "relocate"   .. relocate_parser,   "Relocate the working copy to point to a different repository root URL." },
    { "resolve"    .. resolve_parser,    "Resolve conflicts on working copy files or directories." },
    { "resolved"   .. resolved_parser,   "[Deprecated] Remove “conflicted” state on working copy files or directories." },
    { "revert"     .. revert_parser,     "Undo all local edits." },
    { "status"     .. status_parser,     "Print the status of working copy files and directories." },
    { "switch"     .. switch_parser,     "Update working copy to a different URL." },
    { "unlock"     .. unlock_parser,     "Unlock working copy paths or URLs." },
    { "update"     .. update_parser,     "Update your working copy." },
    { "upgrade"    .. upgrade_parser,    "Upgrade the metadata storage format for a working copy." },

    -- aliases
    { "praise"     .. blame_parser,      "Show author and revision information inline for the specified files or URLs." },
    { "annotate"   .. blame_parser,      "Show author and revision information inline for the specified files or URLs." },
    { "delete"     .. delete_parser,     "Delete an item from a working copy or the repository." },

    -- abbreviations (hidden)
    { hide=true, "ann"   .. blame_parser      },
    { hide=true, "cl"    .. changelist_parser },
    { hide=true, "co"    .. checkout_parser   },
    { hide=true, "del"   .. delete_parser     },
    { hide=true, "rm"    .. delete_parser     },
    { hide=true, "ci"    .. commit_parser     },
    { hide=true, "co"    .. copy_parser       },
    { hide=true, "di"    .. diff_parser       },
    { hide=true, "h"     .. help_parser       },
    { hide=true, "li"    .. list_parser       },
    { hide=true, "mv"    .. move_parser       },
    { hide=true, "pdel"  .. propdel_parser    },
    { hide=true, "pedit" .. propedit_parser   },
    { hide=true, "pget " .. propget_parser    },
    { hide=true, "plist" .. proplist_parser   },
    { hide=true, "pset"  .. propset_parser    },
    { hide=true, "pd"    .. propdel_parser    },
    { hide=true, "pe"    .. propedit_parser   },
    { hide=true, "pg"    .. propget_parser    },
    { hide=true, "pl"    .. proplist_parser   },
    { hide=true, "ps"    .. propset_parser    },
    { hide=true, "st"    .. status_parser     },
    { hide=true, "stat"  .. status_parser     },
    { hide=true, "sw"    .. switch_parser     },
    { hide=true, "up"    .. update_parser     },
  })
