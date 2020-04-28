# Evo-Child-Vorlage für Shop 5.0

Dieses Template dient als Vorlage für ein eigenes Child-Template des Evo.
Es basiert auf dem Evo-Theme "Evo" und enthält alle (und nur die) Dateien, die mindestens in einem Evo-Child-Template
vorhanden sein müssen.
- Alle notwendigen Style- und Less-Dateien sind angelegt, beinhalten aber ausser den notwendigen Vererbungs-Includes 
keine eigenen Änderungen.
- Die bootstrap.css muß aus den less-Dateien kompiliert werden, diese ist also immer gut gefüllt, da sie auch für ein 
Child alle Angaben des Parents enthält.

## Parent Theme ändern

Zum Ändern des Parent-Theme müssen lediglich die Pfade für die Imports in [base.less](themes/base/less/base.less)
und [variables.less](themes/base/less/variables.less) angepasst werden. Anschließend muss die bootstrap.css neu 
kompiliert werden.

## Versionen

- [Shop 5.0](https://gitlab.com/falk.jtl/evo-child-vorlage/tree/master)
- [Shop 4.06](https://gitlab.com/falk.jtl/evo-child-vorlage/tree/release/4.06)

## Related Links

[Templates](http://docs.jtl-shop.de/de/latest/shop_templates/index.html) - Entwickler Dokumentation Templates