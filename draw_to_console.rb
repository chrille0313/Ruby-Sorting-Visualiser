require 'fiddle'
require 'fiddle/struct'
require 'fiddle/cparser'
require 'fiddle/import'

def winsize
    #Ruby 1.9.3 added 'io/console' to the standard library.
    require 'io/console'
    IO.console.winsize
    rescue LoadError
    # This works with older Ruby, but only with systems
    # that have a tput(1) command, such as Unix clones.
   [Integer(`tput li`), Integer(`tput co`)]
end

kernel32 = Fiddle.dlopen("kernel32")

   
$rows, $cols = winsize[0] - 2, winsize[1]  # Make global rows/columns

getstdhandle = Fiddle::Function.new(kernel32["GetStdHandle"], [Fiddle::TYPE_INT], Fiddle::TYPE_INT)

$handle = getstdhandle.call(-11)

module CONSOLEHELPER
    extend Fiddle::Importer
    dlload("kernel32.dll")

    extern 'int WriteConsoleOutputCharacterA(int, void*, int, void*, void*)'
end