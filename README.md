# HasanPrestoQ
A code exercise looking at a PrestoQ API
A single UICollectionViewController displaying a list of Manager Specials.

## To note:
    
    * Calls PrestoQ API for data (and on each data item for it's image)
    * Uses a UICollectionViewController to display data
    * Uses MIT licence
    * Has Unit tests to cover ManagerSpecial  class (should cover all classes)
    * The only place where Accissibility is not automatic (product image) an accessability label has been added
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
    ![Items](README_Screenshots/items.jpg?raw=true "Main Screen")
    ![Items with sparkle](README_Screenshots/items2.jpg?raw=true "Main Screen with sparkle")
