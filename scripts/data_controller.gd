extends Node

## This script is global - autoloaded when the program starts
## Holds signals which are used by different scripts to communicate

signal DataTableClear()
signal DataTableAddEntry(share_price: int, frequency: int, probability: float)
