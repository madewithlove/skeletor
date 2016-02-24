<?php
namespace App\Http\Composers;

use Arrounded\Core\Composers\AbstractComposer;
use Illuminate\View\View;

class LayoutComposer extends AbstractComposer
{
    /**
     * @param View $view
     */
    public function compose(View $view)
    {
        $view->assets = $this->getWebpackAssets();
    }
}
