{block name='account-downloads'}
    {if !empty($Bestellung->oDownload_arr)}
        {block name='account-downloads-subheading'}
            <div class="h2">{lang key='yourDownloads'}</div>
        {/block}
        {block name='account-downloads-order-downloads'}
            {foreach $Bestellung->oDownload_arr as $oDownload}
                {card no-body=true class="cols-12 col-md-8 download-item"}
                    {cardheader id="download-{$oDownload@iteration}"}
                        {button
                            variant="link"
                            role="button"
                            block=true
                            aria=["expanded"=>"false","controls"=>"collapse-download-{$oDownload@iteration}"]
                            data=["toggle"=> "collapse", "target"=>"#collapse-download-{$oDownload@iteration}"]
                        }
                            {block name='account-downloads-order-downloads-item-heading'}
                                {$oDownload->oDownloadSprache->getName()}
                            {/block}
                        {/button}
                    {/cardheader}
                    {collapse id="collapse-download-{$oDownload@iteration}" visible=false}
                        {cardbody}
                            {block name='account-downloads-order-downloads-item-body'}
                                {row}
                                    {col md=4}{lang key='downloadOrderDate'}:{/col}
                                    {col md=8}{$Bestellung->dErstellt|default:"--"|date_format:"%d.%m.%Y %H:%M"}{/col}
                                {/row}
                                {row}
                                    {col md=4}{lang key='downloadLimit'}:{/col}
                                    {col md=8}{$oDownload->cLimit|default:{lang key='unlimited'}}{/col}
                                {/row}
                                {row}
                                    {col md=4}{lang key='validUntil'}:{/col}
                                    {col md=8}{$oDownload->dGueltigBis|default:{lang key='unlimited'}}{/col}
                                {/row}
                                {row}
                                    {col md=4}{lang key='download'}:{/col}
                                    {col md=8}
                                        {if $Bestellung->cStatus == $smarty.const.BESTELLUNG_STATUS_BEZAHLT
                                        || $Bestellung->cStatus == $smarty.const.BESTELLUNG_STATUS_VERSANDT
                                        || $Bestellung->cStatus == $smarty.const.BESTELLUNG_STATUS_TEILVERSANDT}
                                            {form method="post" action="{get_static_route id='jtl.php'}" slide=true}
                                                {input name="a" type="hidden" value="getdl"}
                                                {input name="bestellung" type="hidden" value=$Bestellung->kBestellung}
                                                {input name="dl" type="hidden" value=$oDownload->getDownload()}
                                                {block name='account-downloads-order-downloads-item-download-button'}
                                                    {button size="sm" type="submit" variant="outline-primary"}
                                                        <i class="fa fa-download"></i> {lang key='download'}
                                                    {/button}
                                                {/block}
                                            {/form}
                                        {else}
                                            {lang key='downloadPending'}
                                        {/if}
                                    {/col}
                                {/row}
                            {/block}
                        {/cardbody}
                    {/collapse}
                {/card}
            {/foreach}
        {/block}
    {elseif !empty($oDownload_arr)}
        {block name='account-downloads-customer-downloads'}
            {row}
                {col cols=12 md=6}
                    {card no-body=true class="download-main"}
                        {cardheader}
                            {block name='account-downloads-customer-downloads-heading'}
                                <span class="h3">
                                    {lang key='myDownloads'}
                                </span>
                            {/block}
                        {/cardheader}
                        {cardbody class="download-main-body"}
                            <div id="account-download-accordion">
                                {block name='account-downloads-customer-downloads'}
                                    {foreach $oDownload_arr as $oDownload}
                                        {card no-body=true class="download-item"}
                                            {cardheader id="download-{$oDownload@iteration}"}
                                                {button
                                                    variant="link"
                                                    role="button"
                                                    block=true
                                                    aria=["expanded"=>"false","controls"=>"collapse-download-{$oDownload@iteration}"]
                                                    data=["toggle"=> "collapse", "target"=>"#collapse-download-{$oDownload@iteration}"]
                                                }
                                                    {block name='account-downloads-customer-downloads-item-heading'}
                                                        {$oDownload->oDownloadSprache->getName()}
                                                    {/block}
                                                {/button}
                                            {/cardheader}
                                            {collapse id="collapse-download-{$oDownload@iteration}" visible=false
                                                aria=["labelledby"=>"download-{$oDownload@iteration}"]
                                                data=["parent"=>"#account-download-accordion"]
                                            }
                                                {cardbody}
                                                    {block name='account-downloads-customer-downloads-item-body'}
                                                        {assign var=cStatus value=$smarty.const.BESTELLUNG_STATUS_OFFEN}
                                                        {foreach $Bestellungen as $Bestellung}
                                                            {if $Bestellung->kBestellung == $oDownload->kBestellung}
                                                                {assign var=cStatus value=$Bestellung->cStatus}
                                                                {assign var=dErstellt value=$Bestellung->dErstellt}
                                                            {/if}
                                                        {/foreach}
                                                        {row}
                                                            {col md=4}{lang key='downloadOrderDate'}:{/col}
                                                            {col md=8}{$dErstellt|default:"--"|date_format:"%d.%m.%Y %H:%M"}{/col}
                                                        {/row}
                                                        {row}
                                                            {col md=4}{lang key='downloadLimit'}:{/col}
                                                            {col md=8}{$oDownload->cLimit|default:{lang key='unlimited'}}{/col}
                                                        {/row}
                                                        {row}
                                                            {col md=4}{lang key='validUntil'}:{/col}
                                                            {col md=8}{$oDownload->dGueltigBis|default:{lang key='unlimited'}}{/col}
                                                        {/row}
                                                        {row}
                                                            {col md=4}{lang key='download'}:{/col}
                                                            {col md=8}
                                                            {form method="post" action="{get_static_route id='jtl.php'}" slide=true}
                                                                {input name="kBestellung" type="hidden" value=$oDownload->kBestellung}
                                                                {input name="kKunde" type="hidden" value=$smarty.session.Kunde->kKunde}
                                                                {if $cStatus == $smarty.const.BESTELLUNG_STATUS_BEZAHLT
                                                                || $cStatus == $smarty.const.BESTELLUNG_STATUS_VERSANDT
                                                                || $cStatus == $smarty.const.BESTELLUNG_STATUS_TEILVERSANDT}
                                                                    {input name="dl" type="hidden" value=$oDownload->getDownload()}
                                                                    {block name='account-downloads-customer-downloads-item-download-button'}
                                                                        {button size="sm" type="submit" variant="outline-primary"}
                                                                            <i class="fa fa-download"></i> {lang key='download'}
                                                                        {/button}
                                                                    {/block}
                                                                {else}
                                                                    {lang key='downloadPending'}
                                                                {/if}
                                                            {/form}
                                                            {/col}
                                                        {/row}
                                                    {/block}
                                                {/cardbody}
                                            {/collapse}
                                        {/card}
                                    {/foreach}
                                {/block}
                            </div>
                        {/cardbody}
                    {/card}
                {/col}
            {/row}
        {/block}
    {/if}
{/block}
