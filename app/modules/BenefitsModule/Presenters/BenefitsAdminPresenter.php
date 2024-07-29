<?php

declare(strict_types=1);

namespace Crm\BenefitsModule\Presenters;

use Crm\AdminModule\Presenters\AdminPresenter;

/**
 * Class BenefitsAdminPresenter
 *
 * @package App\Presenter
 *
 * This class represents a presenter for the BenefitsAdmin module in the application.
 * It extends the AdminPresenter class.
 */
class BenefitsAdminPresenter extends AdminPresenter
{
    /**
     * The startup method is called before the request is processed.
     * This method is responsible for performing certain initialization tasks.
     *
     * @return void
     */
    public function startup(): void
    {
        parent::startup();

        $this->onlyLoggedIn();
    }

    /**
     * The renderDefault method is called to render the default template.
     * It sets the userId variable in the template by retrieving the user's userId from the current user.
     *
     * @return void
     */
    public function renderDefault(): void
    {
//        $this->template->userId = $this->getUser()->getUserId();
    }
}
