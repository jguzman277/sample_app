// Import and register all your controllers from the files below

import { application } from "./application"

import DropdownController from "./dropdown_controller.js"
application.register("dropdown", DropdownController)

import NavbarController from "./navbar_controller.js"
application.register("navbar", NavbarController)

import NotificationsController from "./notifications_controller.js"
application.register("notifications", NotificationsController)