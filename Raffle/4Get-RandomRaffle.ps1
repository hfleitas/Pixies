$Evals = $(foreach ($line in Get-Content "C:\fleitasarts\20190608-SQLSaturdaySFL864\Pixies\Raffle\2Eval.txt") {$line.tolower().split(" ")}) | sort | Get-Unique
echo $Evals > "C:\fleitasarts\20190608-SQLSaturdaySFL864\Pixies\Raffle\unique-sorted.txt"
Get-Random -Input $Evals -Count 2 > "C:\fleitasarts\20190608-SQLSaturdaySFL864\Pixies\Raffle\Winners.txt"
