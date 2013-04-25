package
{

import GameComponets.loaders.ModalContainer;

import Othe.NavigationController;


import flash.display.Sprite;


[SWF(width="800", height="600",frameRate="60")]
[Frame(factoryClass="Preloader")]


public class Main extends Sprite
{

    private var navigationController : NavigationController = new NavigationController();

    public function Main()
    {
        addChild(navigationController);
        addChild(ModalContainer.rootConteiner);
        addChild(ModalContainer.containerForPlayAgain);
    }

}
}