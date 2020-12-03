$map = [IO.File]::ReadAllLines('.\2020\day3\map.txt')

$arrayPosX = 3
#$currentPosY = 0
$treesHit = 0
$maxHeight = $map.Count


function calculateCorrectXPos($position){
    $maxWidth  = $map[0].length -1
    if($position -gt $maxWidth){
        $position = $position - $maxWidth
        #Added another -1 to account for zero index
        return calculateCorrectXPos($position -1)
    }else{
        return $position
    }
}

#Each loop will increase our Y by 1
#Need to begin on level 1 instead of level 0 as we don't need to check the first row
For($PosY=1; $PosY -lt $maxHeight; $PosY++){
    $arrayPosX = calculateCorrectXPos($arrayPosX)
    $object = $map[$PosY][$arrayPosX]
    #Write-Host "Checked Y: $PosY and X: $arrayPosX object was: $object"
    #$currentPosY = $PosY
    if($object -eq "#"){
        $treesHit++
    }
    $arrayPosX +=3
    
    Write-Progress -Id 1 -Activity "Current Depth:" -Status $PosY
    #traverse 3 steps to the right
    # For ($i=0; $i -lt 3; $i++) {
        
    #     #Cant use $i as our X movement
    #     #$currentPosX++ 
    #     Write-Progress -Id 2 -Activity "Current Step:" -Status $arrayPosX
        
    # }
    if($object){
         Write-Progress -Id 3 -Activity "Object Hit:" -Status $object
    }
    else {
        Write-Host "Null on Y:$currentPosY X:$arrayPosX"
    }
    
    Write-Progress -Id 4 -Activity "Trees Hit:" -Status $treesHit
    #Do not count value directly below
    
}

Write-Host "We encountered $treesHit trees on our journey!"

# This was no longer followed - preserving for history
<#
Set our variables

Loop through array:
    Enter array at level 0
    Move 3 steps to the right via loop
        Have we overflowed
            Yes:
                Function call: calculate the correct X position by resetting array X pos back to beginning
                Continue
            No:
                Continue
        
        Have we found a tree? Increment trees hit
        Keep track of our calculated X position

#>