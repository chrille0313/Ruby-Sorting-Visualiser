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
    dlload(Dir.pwd + "/WRITECONSOLE.dll")

    extern 'void WriteToConsole(int, void*, int, int, int)'
end


# Draw visualization
def visualize(numbers, sleep_time=1)
    
    # Make drawing-grid
    console_rows = []

    row = 0
    while row < $rows
        console_rows[row] = " " * $cols
        
        row += 1
    end
    
    i = 0
    while i < numbers.length
        j = $rows - numbers[i]

        while j < $rows - 1
            #console_rows[j][i] = "█"
            console_rows[j][i] = "X"
            
            j += 1
        end

        i += 1
    end


    # Make borders around drawing area
    for border in 0..$rows - 1 do
        console_rows[border][0] = "|"
        console_rows[border][$cols - 1] = "|"
    end

    for border in 0..$cols - 1 do
        console_rows[0][border] = "-"
        console_rows[$rows - 1][border] = "-"
    end

    console_rows[0][0] = "+"
    console_rows[0][$cols-1] = "+"
    console_rows[$rows-1][0] = "+"
    console_rows[$rows-1][$cols-1] = "+"


    # Draw rows
    final_field = ""
    for row in console_rows do
        final_field += row
    end
    #system("cls")
    CONSOLEHELPER.WriteToConsole($handle, final_field, final_field.length, 0,0)

    #puts(final_field)
    sleep(sleep_time/1000)
end
