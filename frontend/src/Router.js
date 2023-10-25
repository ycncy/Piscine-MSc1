import {createRouter, createWebHistory} from "vue-router";
import User from "@/components/User.vue";
import Clocks from "@/components/Clocks.vue";

const Router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: "/user",
            component: User
        },
        {
            path: "/clocks",
            component: Clocks
        }
    ]
});

export default Router;