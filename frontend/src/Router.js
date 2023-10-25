import {createRouter, createWebHistory} from "vue-router";
import User from "@/components/User.vue";
import WorkingTimes from "@/components/WorkingTimes.vue";

const Router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: "/workingtimes",
            component: WorkingTimes
        }, 
        {
            path: "/user",
            component: User
        }
        
    ]
});

export default Router;