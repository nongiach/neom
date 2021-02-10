import neovim
import subprocess
from subprocess import Popen, PIPE, check_output

# https://github.com/neovim/pynvim
def sh(cmd, stdin=""):
    """ run a command, send stdin and capture stdout and exit status"""
    # process = Popen(cmd.split(), stdin=PIPE, stdout=PIPE)
    process = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE)
    process.stdin.write(bytes(stdin, "utf-8"))
    stdout = process.communicate()[0].decode('utf-8').strip()
    process.stdin.close()
    returncode = process.returncode
    return returncode, stdout

@neovim.plugin
class Main(object):
    def __init__(self, vim):
        self.vim = vim

    def title_level(self, line):
        i = 0
        while i < len(line) and line[i] == "#":
            i += 1
        return i

    def find_previous_title_level(self, cur_row):
        for row in range(cur_row - 2, -1, -1):
            level = self.title_level(self.vim.current.buffer[row])
            if level > 0:
                return level
        return 0

    def echo(self, msg):
        self.vim.command(f'echo "{msg}"')

    @property 
    def buffer(self):
        return self.vim.current.buffer

    @property
    def current_line(self):
        row, col = self.vim.current.window.cursor
        # (row is 1-based, col is 0-based) 
        return self.buffer[row-1]

    @current_line.setter
    def current_line(self, new_line):
        row, col = self.vim.current.window.cursor
        self.buffer[row-1] = new_line

    @neovim.function('UpdateCurrentTitleLevel')
    def do_update_current_title_level(self, args):
        if len(self.current_line) == 1 and self.current_line.endswith('#'):
            cur_row, cur_col = self.vim.current.window.cursor
            level = self.find_previous_title_level(cur_row)
            self.current_line = '#' * level
            self.vim.command(f'echo "level = {level}"')
            self.vim.command('startinsert!')
        else:
            self.vim.feedkeys('a')

    @neovim.function('NeomGetFold', sync=True)
    def do_neom_get_fold(self, args):
        row = args[0]
        line = self.buffer[row-1]
        if len(line) == 0:
            return "-1"
        # level = self.find_previous_title_level(row)
        # self.echo(level)
        if '#' in line:
            level = line.count('#')
            return f">{level}"
        else:
            return '='

    @neovim.function('NeomInsertNoteLink', sync=True)
    def do_neom_insert_note_link(self, args):
        # sh("""rofi  -dmenu       -kb-row-down 'alt+k' -kb-row-up 'alt+l' -kb-row-left 'alt+j' -kb-row-right 'alt+m'""", stdin="a\nb\nc\nd")
        index, note = sh(""". ~/github/notes/notes.sh; basename $(do_ns_rofi_for_vim_plugin ~/github/notes/*.md)""", stdin="a\nb\nc\nd")

        # self.echo(f"called insert note => {note}")
        self.current_line = self.current_line + note
        return 0
