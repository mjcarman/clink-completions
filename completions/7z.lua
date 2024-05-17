-- argument completion for 7zip
require("arghelper")

--local file_matches     = clink.argmatcher():addarg(clink.filematches)
--local dir_matches      = clink.argmatcher():addarg(clink.dirmatches)
--local password_matches = clink.argmatcher():nofiles()

-- Usage: 7z <command> [<switches>...] <archive_name> [<file_names>...] [@listfile]

clink.argmatcher("7z")
 :_addexarg({
    { "a",  "Add files to archive" },
    { "b",  "Benchmark" },
    { "d",  "Delete files from archive" },
    { "e",  "Extract files from archive (without using directory names)" },
    { "h",  "Calculate hash values for files" },
    { "i",  "Show information about supported formats" },
    { "l",  "List contents of archive" },
    { "rn", "Rename files in archive" },
    { "t",  "Test integrity of archive" },
    { "u",  "Update files to archive" },
    { "x",  "eXtract files with full paths" },
 })
 :_addexflags({
    { "--",    "-- : Stop switches and @listfile parsing" },
    { "-ai",   "-ai[r[-|0]]{@listfile|!wildcard} : Include archives" },
    { "-ax",   "-ax[r[-|0]]{@listfile|!wildcard} : eXclude archives" },
    { "-ao",   "-ao{a|s|t|u} : set Overwrite mode" },
    { "-an",   "-an : disable archive_name field" },
    { "-bb",   "-bb[0-3] : set output log level" },
    { "-bs",   "-bs{o|e|p}{0|1|2} : set output stream for output/error/progress line" },
    { "-bt",   "-bt : show execution time statistics" },
    { "-i",    "-i[r[-|0]]{@listfile|!wildcard} : Include filenames" },
    { "-m",    "-m{Parameters} : set compression Method" },
    { "-mmt",  "-mmt[N] : set number of CPU threads" },
    { "-mx",   "-mx[N] : set compression level: -mx1 (fastest) ... -mx9 (ultra)" },
    { "-o",    "-o{Directory} : set Output directory" },
    { "-p",    "-p{Password} : set Password" },
    { "-r",    "-r[-|0] : Recurse subdirectories for name search" },
    { "-sa",   "-sa{a|e|s} : set Archive name mode" },
    { "-scc",  "-scc{UTF-8|WIN|DOS} : set charset for for console input/output" },
    { "-scs",  "-scs{UTF-8|UTF-16LE|UTF-16BE|WIN|DOS|{id}} : set charset for list files" },
    { "-scrc", "-scrc[CRC32|CRC64|SHA1|SHA256|*] : set hash function for x, e, h commands" },
    { "-sdel", "-sdel : delete files after compression" },
    { "-seml", "-seml[.] : send archive by email" },
    { "-sfx",  "-sfx[{name}] : Create SFX archive" },
    { "-si",   "-si[{name}] : read data from stdin" },
    { "-slp",  "-slp : set Large Pages mode" },
    { "-slt",  "-slt : show technical information for l (List) command" },
    { "-snh",  "-snh : store hard links as links" },
    { "-snl",  "-snl : store symbolic links as links" },
    { "-sni",  "-sni : store NT security information" },
    { "-sns",  "-sns[-] : store NTFS alternate streams" },
    { "-so",   "-so : write data to stdout" },
    { "-spd",  "-spd : disable wildcard matching for file names" },
    { "-spe",  "-spe : eliminate duplication of root folder for extract command" },
    { "-spf",  "-spf : use fully qualified file paths" },
    { "-ssc",  "-ssc[-] : set sensitive case mode" },
    { "-sse",  "-sse : stop archive creating, if it can't open some input file" },
    { "-ssp",  "-ssp : do not change Last Access Time of source files while archiving" },
    { "-ssw",  "-ssw : compress shared files" },
    { "-stl",  "-stl : set archive timestamp from the most recently modified file" },
    { "-stm",  "-stm{HexMask} : set CPU thread affinity mask (hexadecimal number)" },
    { "-stx",  "-stx{Type} : exclude archive type" },
    { "-t",    "-t{Type} : Set type of archive" },
    { "-u",    "-u[-][p#][q#][r#][x#][y#][z#][!newArchiveName] : Update options" },
    { "-v",    "-v{Size}[b|k|m|g] : Create volumes" },
    { "-w",    "-w[{path}] : assign Work directory. Empty path means a temporary directory" },
    { "-x",    "-x[r[-|0]]{@listfile|!wildcard} : eXclude filenames" },
    { "-y",    "-y : assume Yes on all queries" },
 })
