import {createRouter, createWebHistory} from "vue-router";
import WorkingTimes from "@/components/WorkingTimes.vue";
import Chart from "@/components/ChartManager/Chart.vue";
import Clocks from "@/components/Clocks.vue";
import User from "@/components/User.vue";
import UserLayout from "@/components/UserLayout.vue";

const routes = [
    {
        path: '/dashboard',
        component: UserLayout,
        children: [
            {
                path: '',
                component: User,
            },
            {
                path: 'workingTimes/:userID',
                component: WorkingTimes,
                name: "WorkingTimes",
            },
            {
                path: 'workingTime/:userID',
                component: WorkingTimes,
                name: "WorkingTime",
            },
            {
                path: 'clockManager/:userID',
                component: Clocks,
                name: "ClockManager",
            },
            {
                path: 'chartManager/:userID',
                component: Chart,
                name: "ChartManager",
            },
        ],
    },
];

const Router = createRouter({
    history: createWebHistory(),
    routes
});

export default Router;
