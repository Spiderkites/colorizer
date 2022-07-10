# Development

Zum entwickeln muss  ```npm run start:dev ``` ausgeführt werden. Der Server ist dann unter ```localhost:8081``` erreichbar. Änderungen am HTML müssen direkt in der ```index.html``` im _Colorizer_ Block gemacht werden. 

# Deployment
Zum deployment muss  ```npm run build ``` ausgeführt werden. Die resultierende ```main.js``` muss in ```./../NOVAChild/js/custom.js``` kopiert werden. Außerdem muss der  _Colorizer_ Block aus ```index.html``` in ```./../NOVAChild/productdetails/colorizer.tpl``` kopiert werden. 

Im  _Colorizer_ Block muss 

```
<script>
    try {
        window.addEventListener('load', ()=>{
            window.initColorizer('../../svg/product.svg', '../../svg/color.svg');
        })
    } catch (e) { 
        console.log(e);
    }
</script>
```

durch 

```
 <script>
    try {
        window.addEventListener('load', ()=>{
            window.initColorizer('{$Artikel->FunktionsAttribute.colorizer_product}', '{$Artikel->FunktionsAttribute.colorizer_color}');
        })
    } catch (e) { 
        console.log(e);
    }
</script>
```

ersetzt werden. 