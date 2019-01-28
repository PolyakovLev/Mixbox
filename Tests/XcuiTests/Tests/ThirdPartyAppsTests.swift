import MixboxUiTestsFoundation
import XCTest

// TODO: Rewrite, split into smaller atomic tests. Or keep this and just add more tests.
final class ThirdPartyAppsTests: TestCase {
    func test() {
        // Install app, terminate it, so there will be
        // an app installed and home screen will be displayed.
        XCUIApplication().launch()
        XCUIApplication().terminate()
        
        // Go to first page in Springboard app (home screen)
        pageObjects.springboard.anyWindow.swipeRight()
        pageObjects.springboard.anyWindow.swipeRight()
        pageObjects.springboard.anyWindow.swipeRight()
        
        // Assert that we are on the page that doesn't contain app icon.
        // This also checks that visibility check works (there was a bug!).
        pageObjects.springboard.mainAppIcon.currentlyVisible.assert.isNotDisplayed()
        
        deleteApp()
        
        pageObjects.springboard.mainAppIcon.assert.isNotDisplayed()
        
        XCUIDevice.shared.press(.home)
    }
    
    private func deleteApp() {
        // Note: there was a bug. Snapshots were wrong after scrolling
        // when action was executed (it used wrong coordinates).
        //
        // It was fixed by adding _waitForQuiescence to reloadSnapshots() in ScrollingContext
        pageObjects.springboard.mainAppIcon.press(duration: 1)
        
        pageObjects.springboard.mainAppIconDeleteButton.tap()
        
        // Note: there was a bug. Cancel button was tapped instead of delete button.
        // The reason is that XCUI cancels every alert if there is an interaction with other element.
        // Every action in Mixbox performed on XCUIApplication, by coordinates (that fixes some XCUI bugs
        // and makes tests more blackbox, but the reason was really fixing bugs).
        //
        // It was fixed by adding a workaround: tap alert XCUIElement by coordinate instead of tapping
        // XCUIApplication by coordinate.
        pageObjects.springboard.deleteAppAlertButton.tap()
    }
}

private class Springboard: BasePageObjectWithDefaultInitializer {
    var mainAppIcon: ViewElement {
        return element("Main app icon") { element in
            element.type == .icon && element.label == "Tests"
        }
    }
    
    var mainAppIconDeleteButton: ButtonElement {
        return element("Delete button on main app icon") { element in
            element.id == "DeleteButton" && element.type == .button && element.isSubviewOf { element in
                (element.type == .icon /* iOS 10 */ || element.type == .other /* iOS 9 */)
                    && element.label == "Tests"
                    && element.id == "Tests"
            }
        }
    }
    
    var anyWindow: ViewElement {
        return any.element("Any window") { element in
            element.type == .window
        }
    }
    
    var deleteAppAlertButton: ButtonElement {
        return element("Delete button on alert") { element in
            let title = deleteButtonTitles[NSLocale.current.languageCode ?? "English"] ?? "Delete"
            
            return element.type == .button && element.label == title && element.isSubviewOf { element in
                element.type == .alert
            }
        }
    }
}

// IFS=$'\n'; for file in `find "./Contents/Resources/RuntimeRoot/System/Library/AccessibilityBundles/SpringBoard.axbundle/" -name "*.strings"`; do echo -n "$file ::"; plutil -p "$file"|grep "delete.key"; done
private let deleteButtonTitles: [String: String] = [
    "he": "מחק",
    "en_AU": "Delete",
    "ar": "حذف",
    "el": "Διαγραφή",
    "uk": "Видалити",
    "English": "Delete",
    "es_419": "Eliminar",
    "zh_CN": "删除",
    "Dutch": "Verwijder",
    "da": "Slet",
    "sk": "Vymazať",
    "pt_PT": "Apagar",
    "German": "Löschen",
    "ms": "Padam",
    "sv": "Radera",
    "cs": "Smazat",
    "ko": "삭제",
    "yue_CN": "删除",
    "no": "Slett",
    "hu": "Törlés",
    "zh_HK": "刪除",
    "Spanish": "Eliminar",
    "tr": "Sil",
    "pl": "Usuń",
    "zh_TW": "刪除",
    "en_GB": "Delete",
    "French": "Supprimer",
    "vi": "Xóa",
    "ru": "Удалить",
    "fr_CA": "Supprimer",
    "fi": "Poista",
    "id": "Hapus",
    "th": "ลบ",
    "pt": "Apagar",
    "ro": "Ștergeți",
    "Japanese": "削除",
    "hr": "Obriši",
    "hi": "डिलीट करें",
    "Italian": "Elimina",
    "ca": "Eliminar",
]

private extension PageObjects {
    var springboard: Springboard {
        return apps.springboard.pageObject()
    }
}

/*
 UI Test Activity:
 Find: Elements matching predicate 'userTestingAttributes CONTAINS "cancel-button"'
 */
