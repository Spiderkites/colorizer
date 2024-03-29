{block name='productdetails-colorizer'}
   

       <!-- ---------------------------------- COLORIZER START ---------------------------------- -->
<div id="spiderkites-colorizer" style="opacity: 0;">

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

    <div id="product" uuid="UUID-Development" class="row m-3" style="margin: 1rem;">

        <div class="col">
            <object id="productSVG" type="image/svg+xml">
            </object>
        </div>

    </div>

    <div class="row m-3" style="margin: 1rem;">
        <div class="col">
            <div id="product-actions" class="btn-group btn-group-md product-actions hidden-print" role="group">
                <button id="download-btn" class="btn btn-default btn-secondary">
                    <span class="fa fa-download"></span>
                    <span translate class="hidden-sm">DOWNLOAD</span>
                </button>
                <button id="save-btn" class="btn btn-default btn-secondary">
                    <span class="fa fa-save"></span>
                    <span translate class="hidden-sm">SAVE</span>
                </button>
                <button id="load-btn" class="btn btn-default btn-secondary">
                    <span class="fa fa-folder-open"></span>
                    <span translate class="hidden-sm">LOAD</span>
                </button>
                <button id="clear-btn" class="btn btn-default btn-secondary">
                    <span class="fa fa-undo"></span>
                    <span translate class="hidden-sm">CLEAR</span>
                </button>
                <label class="btn btn-default btn-secondary" style="margin-bottom: unset;">
                    <input id="symmetrical-checkbox" type="checkbox" checked style="margin: unset;">
                    <span translate>SYMMETRICAL</span>
                </label>                
                <label id="show-vprofile-checkbox" class="btn btn-default btn-secondary" style="margin-bottom: unset; display: none;">
                    <input id="vprofile-checkbox" type="checkbox" style="margin: unset;">
                    <span translate>VPROFILE</span>
                </label>
                <button type="button" class="btn btn-default btn-secondary" data-toggle="modal" data-target="#myModal">
                    <span class="fa  fa-question"></span>
                </button>
            </div>
        </div>
    </div>

    <div id="color-palet" class="row m-3" style="user-select: none; margin: 1rem;">
        <div class="col">
            <object id="colorSVG" type="image/svg+xml">
            </object>
        </div>
    </div>

    <img src onerror="window.waitForInit()">

    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> 
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel" translate>HELP_TITLE</h4>
                </div>
                <div class="modal-body">
                    <ul style="list-style-type:none; padding-right: 40px;">
                        <li>
                            <span class="fa fa-download"></span>
                            <span translate>HELP_DOWNLOAD</span>
                        </li>
                        <br>
                        <li>
                            <span class="fa fa-save"></span>
                            <span translate>HELP_SAVE</span>
                        </li>
                        <br>
                        <li>
                            <span class="fa fa-folder-open"></span>
                            <span translate>HELP_LOAD</span>
                        </li>
                        <br>
                        <li>
                            <span class="fa fa-undo"></span>
                            <span translate>HELP_CLEAR</span>
                            <br>
                        </li>
                        <br>
                        <li>
                            <span class="fa  fa-check-square"></span>
                            <span translate>HELP_SYMMETRICAL</span>
                        </li>
                        <br>  
                        <li>
                            <span class="fa  fa-check-square"></span>
                            <span translate>HELP_VPROFILE</span>
                        </li>
                        <br>
                        <li><span translate>HELP_HOW_TO_BUY_CUSTOM_PRODUCT</span></li>
                    </ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-secondar" data-dismiss="modal">
                        <span translate>HELP_CLOSE</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- ---------------------------------- COLORIZER END ---------------------------------- -->

{/block}
