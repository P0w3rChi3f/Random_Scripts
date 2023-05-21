<# Picked this up from a Ruby script I cam accross while learning a new buffer overflow technique.

A set consists of 3 bytes,  capital Letter, lowercase letter, number.  Another way to look at it is position1 is \x41 - \x5A, position2 \x61 - \x7A, positiion3 is \x30 - \x39

Based on the output from the Ruby script, I will need a triple loop. Most inner loop (0-9) will loop first, then the middle (a-z) will loop after a full loop of the most inner loop, the the most outter loop will rotate after 26 rotations of the most inner loop or 1 rotation of the middle loop
#>
$maxLoops = 3
$iterator = 0
$pattern = $null

foreach ($cap in ('A'..'Z')) {
    $iterator += 1
    foreach ($lower in ('a'..'z')) {
        foreach ($num in (0..9)) {
            $pattern = $pattern + $cap + $lower + $num

        }# Close inner Foreach
    } # Close middle Foreach
} # Close Outer Foreach


$pattern
