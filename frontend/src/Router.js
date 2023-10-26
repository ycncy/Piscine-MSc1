import {createRouter, createWebHistory} from "vue-router";
import User from "@/components/User.vue";
import Clocks from "@/components/Clocks.vue";
import WorkingTimes from "@/components/WorkingTimes.vue";
import Line from "@/components/Line.vue";

const Router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: "/workingtimes",
            component: WorkingTimes
        },
        {
            path: "/clocks",
            component: Clocks
        },
        {
            path: "/line",
            component: Line
        }
    ]
});

export default Router;