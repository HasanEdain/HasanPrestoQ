# HasanPrestoQ

    A code exercise looking at a PrestoQ API
    A single UICollectionViewController displaying a list of Manager Specials.

## Requirements
    Xcode 10.1 (or later)
    Swift 4.2
    Internet connection that can reach PrestoQ endpoint

## Install / run
1. checkout repository
1. run in Xcode

## Unit test
Unit tests exist for a single class, in a delivery environment more classes should be tested more thouroughly 

## To note:
    
    * Calls PrestoQ API for data (and on each data item for it's image)
    * Uses a UICollectionViewController to display data
    * MIT licence
    * Has Unit tests to cover ManagerSpecial  class (should cover all classes)
    * Accessabity traits altered slightly to give the user a better notion of the purpose of each field.
    * The "Cell Width" data downloaded is respected for layout purposes. This results in some unusable cells. A realimplementation would handle this case.
    * Drop shadows and rounded rects for cells (there is a bug on the drop shadow that makes it rectangular)
    * Uses currency formatter with the current locale so that if you change region, the currency symbol is appropriate (unit tests will fail)
    * Added a particle effect overlaid above the product image

## Thoughts on improvements
    
    * If cell is not right type handling 
    * Localization
    * Todo audit
    * pull to refresh
    * refresh poll?
    * Spinner durring data load (initial and product images)
    * Error communication to the user
    * Better Icon and Splash Screen
    * Refine sparkle effect
    
## Screenshots
![Screenshot](README_Screenshots/Items.png?raw=true "Screenshot")
![Screenshot](README_Screenshots/Items2.png?raw=true "Screenshot with sparkle")
