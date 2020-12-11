<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/header/header.png">
<img align="right" src="https://github.com/jwd-ali/PopUpManager/blob/main/Images/ezgif.com-gif-maker%20(1).gif"  width = "420"/>

# PopUpManager
> iOS reusable popups and alerts presentation
___

<p> 
  

<a href="https://www.linkedin.com/in/jawad-ali-3804ab24/"><img src="https://i.imgur.com/vGjsQPt.png" width="134" height="34"></a>  

</br></br>

For making custom PopUp We can’t use UIAlertController because it has to be fully customizable. We can’t use 3rd party libs because they are always limiting us in specific ways. So maybe we’ll make some base class that has the show and dismiss methods with sliding animation. If you think this solution is trivial, think again. Some developers would create a view, constraints, animations, buttons actions, all inside view controller. This view has zero reusability or maintainability

Then you overhear designer saying we will also be needing different sized popups, with other animations. Some will have background fading presentation. This background can block user taps and optionally close the popup. Others will be small, more like a tooltip

UIKit has given us the best way to handle these popups, and it’s called `UIViewControllerTransitioningDelegate`. It has a few parts, but once you write it, you shorten your development time. Peculiarly, I didn’t encounter tutorials that explain how to use this for everyday and straightforward things like popups.

In this specific popUp example i am using tableView to select an option. I am using `UIViewControllerTransitioningDelegate` with `UIPresentationController` for custom transition. The trasition in this specific example is like `preesent` but changing `SlideInPresentationAnimator` to any of your choice can change this aimation to fade in or our and even right left , bounce or spring  
