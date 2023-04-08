# Challenge 3 - There is a nested. Below is the function where we pass in the object and a key and get back the value.

function Get-NestedObjectValue {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $Object,
        [Parameter(Mandatory = $true)]
        $Key
    )

    $Keys = $Key -split '/'
    $Value = $Object

    foreach ($k in $Keys) {

        $Value = $Value.$k
    }

    return $Value
}

# Inputs

$Object1 = @{"a" = @{"b" = @{"c" = "d" } } }
$key1 = 'a/b/c'

# Calling Function

Get-NestedObjectValue -Object $object1 -Key $key1  # Returns 'd'

# Inputs

$Object2 = @{"x" = @{"y" = @{"z" = "a" } } }
$key2 = 'x/y/z'

# Calling Function

Get-NestedObjectValue -Object $object2 -Key $key2  # Returns 'a'

