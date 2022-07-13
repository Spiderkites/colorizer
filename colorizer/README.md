# Development

Zum entwickeln muss  ```npm run start:dev ``` ausgeführt werden. Der Server ist dann unter ```localhost:8081``` erreichbar. Änderungen am HTML müssen direkt in der ```index.html``` im _Colorizer_ Block gemacht werden. 

# Deployment
Zum deployment muss  ```npm run build ``` ausgeführt werden. Die resultierende ```main.js``` muss in ```./../NOVAChild/js/custom.js``` kopiert werden. Außerdem muss der  _Colorizer_ Block aus ```index.html``` in ```./../NOVAChild/productdetails/colorizer.tpl``` kopiert werden. 

Im  _Colorizer_ Block muss 

```
<script>
        window.waitForInit = function(){
            let stateCheck = setInterval(() => {
            if (document.readyState === 'complete') {
                clearInterval(stateCheck);
                window.initColorizer('../../svg/product.svg', '../../svg/color.svg');
            }
            }, 50);
        }
    </script>
```

durch 

```
<script>
        window.waitForInit = function(){
            let stateCheck = setInterval(() => {
            if (document.readyState === 'complete') {
                clearInterval(stateCheck);
                 window.initColorizer('{$Artikel->FunktionsAttribute.colorizer_product}', '{$Artikel->FunktionsAttribute.colorizer_color}');
            }
            }, 50);
        }
    </script>
```

ersetzt werden. 