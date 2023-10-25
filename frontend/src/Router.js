import {createRouter, createWebHistory} from "vue-router";
import User from "@/components/User.vue";

const Router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: "/user",
            component: User
        }
    ]
});

export default Router;