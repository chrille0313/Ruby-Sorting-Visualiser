require_relative 'visualizer.rb'


# Bubblesort
def bubblesort(arr)
    arrLength = arr.length - 1

    for counter in 0..arrLength
        for i in 0..(arrLength - counter - 1)
            if arr[i] > arr[i + 1]
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                visualize_cmd(arr, 100) #  Draw in cmd
                #visualize(arr) # Draw in ruby2d
                #Sound.beep(arr[i] * 100, 150)
            end
        end
    end

    #for item in arr do
    #    Sound.beep(item * 100, 10)
    #end

    #Sound.play("SystemAsterisk", Sound::ALIAS)
end


# Quicksort
def swap(arr, pos1, pos2)
    arr[pos1], arr[pos2] = arr[pos2], arr[pos1]
    visualize_cmd(arr, 100) #  Draw in cmd
    #visualizer(arr) # Draw in ruby2d
end

def partition(arr, low, high)
    pivotValue = arr[high]
    pivotIndex = low

    for i in low..high do
        if arr[i] < pivotValue
            swap(arr, i, pivotIndex)
            pivotIndex += 1
        end
    end

    swap(arr, pivotIndex, high)
    return pivotIndex
end

def quicksort(arr, low=0, high=-1)
    if high == -1
        high = arr.length - 1
    end
    
    if low < high
        index = partition(arr, low, high)
        quicksort(arr, low, index - 1)
        quicksort(arr, index + 1, high)
    end
end



numbers = []
for i in 1..$rows - 1 do
    numbers.append(i)
end

numbers = numbers.shuffle
bubblesort(numbers)

sleep(3)

numbers = numbers.shuffle
quicksort(numbers)

sleep(3)
system("cls")