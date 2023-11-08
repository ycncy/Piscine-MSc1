import {createRouter, createWebHistory} from "vue-router";
import Chart from "@/components/ChartManager/Chart.vue";
import Clocks from "@/components/Clocks.vue";
import UserLayout from "@/components/UserLayout.vue";
import WorkingTimeEditor from "@/components/WorkingTimes.vue";
import NotFound from "@/components/Errors/NotFound.vue";
import DashboardHome from "@/components/DashboardHome.vue";
import Login from "@/components/Authentication/Login.vue";

const routes = [
    {
        path: "/login",
        component: Login
    },
    {
        path: "",
        component: UserLayout,
        redirect: "/dashboard",
        children: [
            {
                path: ':pathMatch(.*)*',
                component: NotFound
            },
            {
                path: '/dashboard',
                children: [
                    {
                        path: "",
                        component: DashboardHome
                    },
                    {
                        path: 'workingTimes/:userID',
                        component: WorkingTimeEditor,
                        name: "WorkingTimes",
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
        ]
    }
];

const Router = createRouter({
    history: createWebHistory(),
    routes
});

export default Router;
