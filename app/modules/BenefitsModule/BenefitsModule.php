<?php

declare(strict_types=1);

namespace Crm\BenefitsModule;

use Contributte\Translation\Exceptions\InvalidArgument;
use Crm\ApplicationModule\CrmModule;
use Crm\ApplicationModule\Models\Menu\MenuContainerInterface;
use Crm\ApplicationModule\Models\Menu\MenuItem;

/**
 * Class BenefitsModule
 *
 * @package App\Modules
 */
class BenefitsModule extends CrmModule
{
    private const ICON = 'fa fa-university';
    private const PRIORITY = 100;

    /**
     * Registers admin menu items.
     *
     * @param MenuContainerInterface $menuContainer The menu container interface.
     *
     * @return void
     * @throws InvalidArgument
     */
    public function registerAdminMenuItems(MenuContainerInterface $menuContainer): void
    {
        $mainMenu = new MenuItem('', '#', self::ICON, self::PRIORITY);
        $menuItem = new MenuItem($this->translator->translate('benefits.menu.benefits_admin'), ':Benefits:BenefitsAdmin:', self::ICON, self::PRIORITY);

        $mainMenu->addChild($menuItem);
        $menuContainer->attachMenuItem($mainMenu);
    }
}
