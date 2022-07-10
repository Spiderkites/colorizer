{block name='boxes-box-news-categories'}
    <div class="box box-newscategories box-normal" id="sidebox{$oBox->getID()}">
        {block name='boxes-box-news-categories-content'}
            {block name='boxes-box-news-categories-toggle-title'}
                {link id="crd-hdr-{$oBox->getID()}"
                    href="#crd-cllps-{$oBox->getID()}"
                    data=["toggle"=>"collapse"]
                    role="button"
                    aria=["expanded"=>"false","controls"=>"crd-cllps-{$oBox->getID()}"]
                    class="box-normal-link dropdown-toggle"}
                    {lang key='newsBoxCatOverview'}
                {/link}
            {/block}
            {block name='boxes-box-news-categories-title'}
                <div class="productlist-filter-headline d-none d-md-flex">
                    {lang key='newsBoxCatOverview'}
                </div>
            {/block}
            {block name='boxes-box-news-categories-collapse'}
                {collapse
                    class="d-md-block"
                    visible=false
                    id="crd-cllps-{$oBox->getID()}"
                    aria=["labelledby"=>"crd-hdr-{$oBox->getID()}"]}
                    {nav vertical=true class="box-nav-item"}
                        {foreach $oBox->getItems() as $newsCategory}
                            {navitem href=$newsCategory->cURLFull title=$newsCategory->cName router-class="box-link-wrapper"}
                                {$newsCategory->cName}
                                {badge variant="outline-secondary"}{$newsCategory->nAnzahlNews}{/badge}
                            {/navitem}
                        {/foreach}
                    {/nav}
                {/collapse}
            {/block}
        {/block}
    </div>
    {block name='boxes-box-news-categories-hr-end'}
        <hr class="box-normal-hr">
    {/block}
{/block}
