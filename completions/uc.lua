-- argument completion for ultracompare
require("arghelper")

local string_matches = clink.argmatcher():addarg({fromhistory=true})
local title_matches  = clink.argmatcher():addarg({fromhistory=true})
local number_matches = clink.argmatcher():nofiles()

clink.argmatcher("uc")
  :_addexflags({
    { "-3",                                                "3-way text compare mode" },
    { "-a",                                                "sets Show All" },
    { "-B",                                                "ignore blank lines in text compare mode" },
    { "-b",                                                "ignore spaces in text compare mode" },
    { "-d",                                                "folder compare mode" },
    { "-dmb",                                              "sets Folder Compare type to Basic" },
    { "-dmf",                                              "sets Folder Compare type to Full" },
    { "-dms",                                              "sets Folder Compare type to Smart" },
    { "-esc",                                              "sets UC to be dismissed when ESC is pressed" },
    { "-fb",                                               "force all files to be compared as binary in folder compare mode" },
    { "-ft",                                               "force all files to be compared as text in folder compare mode" },
    { "-gitdt",                                            "invokes Git diff mode" },
    { "-gitm",                                             "invokes Git merge mode" },
    { "-horz",                                             "sets view to horizontal layout" },
    { "-i",                                                "ignore case in text compare mode" },
    { "-ignb"   .. string_matches, " <string>",            "ignore lines that start with 'string'" },
    { "-ignc"   .. string_matches, " <string>",            "ignore lines that contain 'string'" },
    { "-igne"   .. string_matches, " <string>",            "ignore lines that end with 'string'" },
    { "-ignbtw" .. string_matches, " <string1> <string2>", "ignore all text between 'string1' and 'string2'" },
    { "-ignfb"  .. number_matches, " <n>",                 "ignore defined number of lines at beginning of file" },
    { "-ignte"  .. number_matches, " <n>",                 "ignore defined number of lines at end of file" },
    { "-lt",                                               "ignore line terminators" },
    { "-m",                                                "sets Show Matching" },
    { "-mc",                                               "set Show Matching Columns (Table Compare)" },
    { "-mr",                                               "set Show Matching Rows (Table Compare)" },
    { "-ne",                                               "set Show Differences" },
    { "-nec",                                              "set Show Different Columns (Table Compare)" },
    { "-ner",                                              "set Show Different Rows (Table Compare)" },
    { "-o",                                                "creates output file" },
    { "-op",                                               "appends output to specified file" },
    { "-p",                                                "fast binary compare mode" },
    { "-prf",                                              "runs specified session profile" },
    { "-qc",                                               "quick difference check performs a byte by byte check until the first difference is detected" },
    { "-r",                                                "compare folders recursively in folder compare mode" },
    { "-rio",                                              "reset ignore options" },
    { "-rom",                                              "read only merge mode" },
    { "-t",                                                "text compare mode" },
    { "-tb",                                               "table compare mode" },
    { "-title1" .. title_matches, " <title>",              "sets alias/title name for file/folder in first pane" },
    { "-title2" .. title_matches, " <title>",              "sets alias/title name for file/folder in second pane" },
    { "-title3" .. title_matches, " <title>",              "sets alias/title name for file/folder in third pane" },
    { "-vert",                                             "sets view to vertical layout" },
    { "-w",                                                "3-way folder compare mode" },
    { "-x",                                                "smart binary compare mode" },
  })
