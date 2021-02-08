import neovim

# https://github.com/neovim/pynvim

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
        return 1

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

    @neovim.function('NeomGetFold')
    def do_neom_get_fold(self, args):
        level = self.find_previous_title_level(args[0])
        return level
