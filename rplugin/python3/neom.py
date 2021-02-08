import neovim

@neovim.plugin
class Main(object):
    def __init__(self, vim):
        self.vim = vim

    def title_level(line):
        i = 0
        while line[i] == "#":
            i += 1
        return i

    @neovim.function('UpdateCurrentTitleLevel')
    def doItPython(self, args):
        row, col = self.vim.current.window.cursor
        buffer = self.vim.current.buffer
        if len(buffer[row-1]) == 1:
            i = 0
            for row in range(len(buffer)):
                if buffer[row].startswith('#'):
                    i+= 0
            self.vim.command(f'echo "i = {i}"')

