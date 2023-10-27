import {createRouter, createWebHistory} from "vue-router";
import User from "@/components/User.vue";
import Clocks from "@/components/Clocks.vue";
import WorkingTimes from "@/components/WorkingTimes.vue";
import Line from "@/components/Line.vue"
import Bar from "@/components/Bar.vue"
import Radar from "@/components/Radar.vue"
import Pie from "@/components/Pie.vue"
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
            path: "/Line",
            component: Line
        
        },
        {
            path: "/Bar",
            component: Bar
        
        },
        {
            path: "/Pie",
            component: Pie
        
        },
        {
            path: "/Radar",
            component: Radar
        
        }
    ]
});

export default Router;