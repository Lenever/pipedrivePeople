**1. How would you implement asynchronous data downloading, saving and presenting to UI? What are the main difficulties?**

I would create a class to handle downloading the data and another class to handle saving to and reading from local storage, all on a background thread. Then I will display to the UI on the main thread when the saving is completed after downloading each piece of data. Essentially treating each task like creating the object, persisting, and updating objects as operations.

I believe the major difficulties may include:
- Choosing the right storage to save the data, and this will be based on the type and size of data
- Making the downloading, saving and retreiving of the data thread safe
- Making sure this process doesn't take a lot of device power



**2. How would you deal with 10s or 100s of thousands of different objects to synchronise with offline storage? What are the main difficulties?**

I would use a local database like Realm(Preffered) or CoreData to manage saving these different objects

The major difficulties I may encounter will include:
- Maintaining unique identifiers for each individual object
- Managing possible errors that might occur from handling such large amount of data



**3. Imagine that you are developing multi-language app that supports 40 languages.
Describe how you will:**
● Design UI to be responsive to language change.
● Test localisation quality.
● What other possible difficulties you can imagine to be present in this
situation?

I will localize the strings I want to support in the different languages, probably using a code generator like [SwiftGen](https://github.com/SwiftGen/SwiftGen) to avoid manually adding these strings to all the files one by one and avoiding duplicates, then I would use a translation management system like [Phrase](https://phrase.com/cli/) to manage translation outside the app, and syncing it with the localized strings periodically

Problems I see arising from this include:
- Maintaining unique strings for all cases
- Possiblilities of the localised files on the project and the ones on Phrase being out of sync
