require_relative 'draw_to_console.rb'
require 'ruby2d'
require 'win32/sound'
include Win32


# Ruby2d Visualization

set title: "Sorting Visualizer", width: 800, height: 800, diagnostics: true  # Window properties



Triangle.new

def visualize(numbers, current=0, checking=1, ticks=1)

    barWidth = Window.width.to_f / numbers.length.to_i

    update do
        clear

        numbers.each_with_index do |number, index|
            currentRect = Rectangle.new(x: index * barWidth, y: Window.height - number, width: barWidth, height: number)
        
            if index == current
                currentRect.color = 'green'
            elsif index == checking
                currentRect.color = 'red'
            else
                currentRect.color = 'white'
            end
        end

        arrLength = numbers.length - 1

        for counter in 0..arrLength
            for i in 0..(arrLength - counter - 1)
                if numbers[i] > numbers[i + 1]
                    numbers[i], numbers[i + 1] = numbers[i + 1], numbers[i]

                end
            end
        end

    end

    show

end

=begin
numbers = []
for i in 1..25 - 1 do
    numbers.append(rand(Window.height))
end

numbers = numbers.shuffle

visualize(numbers)
=end

# Cmd visualization
def visualize_cmd(numbers, sleep_time=1)
    
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
            console_rows[j][i] = "█"
            #console_rows[j][i] = "|"
            
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

    
    free = Fiddle::Function.new(Fiddle::RUBY_FREE, [Fiddle::TYPE_VOIDP], Fiddle::TYPE_VOID)
    p = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INT, free)
    
    coord = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INT, free)
    coord = 0
    
    CONSOLEHELPER.WriteConsoleOutputCharacterA($handle, final_field, final_field.length, coord, p)

    #puts(final_field)
    sleep(sleep_time.to_f/1000.0)
end
