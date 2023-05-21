# Hex to Decimal
[convert]::ToString(0x1c, 10)

# Hex to binary
[convert]::ToString(0x81 ,2)

# Binary to Decimal
[convert]::ToInt32(11000000,2)

# Decimal to Ascii
[char][byte]46

#Ascii to Decimal
[int[]][char[]]'tfzbwlyzljylawhzzdvyk'
[int][char]"t"

$myConversion = @()
foreach ($letter in ([int[]][char[]]'tfzbwlyzljylawhzzdvyk')) {$myConversion += [char][byte]($letter -7)}

# Hex to Ascii
$hexString = "c0"
$asciiChars = $hexString -split ' ' |ForEach-Object {[char][byte]"0x$_"}
$asciiString = $asciiChars -join ''
$asciiString

# Base64 Encode
$Text = 'This is a secret and should be hidden'
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($Text)
$EncodedText =[Convert]::ToBase64String($Bytes)
$EncodedText

# Base64 Decode
$EncodedText = "VABoAGkAcwAgAGkAcwAgAGEAIABzAGUAYwByAGUAdAAgAGEAbgBkACAAcwBoAG8AdQBsAGQAIABiAGUAIABoAGkAZABlAG4A"
$DecodedText = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($EncodedText))
$DecodedText

# Powers
# [math]::pow(<num>,<exponent>)
(5 * [math]::pow(16,3)) + (2 * [math]::pow(16,2)) + (14 * [math]::pow(16,1)) + (7 * [math]::pow(16,0))

# Convert IP to Binary
$ipv4="192.168.12.33"
-join ($ipv4).split(".") | foreach-object {[system.convert]::tostring($_, 2).padleft(8, "0")}
#-join is the output of combining multiple result objects or array elements together.

# Covert Binary to IP: Option 2
$ipv4.split(".") | foreach-object {
    "{0,3}:{1}" -f $_, [system.convert]::tostring($_,2).padleft(8, "0")
   }