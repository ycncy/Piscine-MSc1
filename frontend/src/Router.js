import {createRouter, createWebHistory} from "vue-router";
import Chart from "@/components/ChartManager/Chart.vue";
import UserLayout from "@/components/UserLayout.vue";
import WorkingTimes from "@/components/WorkingTimes.vue";
import PersonalWorkingTimes from "@/components/Profile/PersonalWorkingTimes.vue";
import NotFound from "@/components/Errors/NotFound.vue";
import DashboardHome from "@/components/DashboardHome.vue";
import Login from "@/components/Authentication/Login.vue";
import PersonalCharts from "@/components/Profile/PersonalCharts.vue";
import Profile from "@/components/Profile/Profile.vue";
import TeamDashboard from "@/components/TeamDashboard.vue";
import Timer from "@/components/Timer.vue";

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
                        component: TeamDashboard
                    },
                    {
                        path: ":userID",
                        component: TeamDashboard,
                        name: "TeamDashboard"
                    },
                    {
                        path: 'profile/workingTimes',
                        component: PersonalWorkingTimes,
                        name: "PersonalWorkingTimes",
                    },
                    {
                        path: 'profile/chartManager',
                        component: PersonalCharts,
                        name: "PersonalChartManager",
                    },
                    {
                        path: 'profile',
                        component: Profile,
                        name: 'Profile'
                    },
                    {
                        path: '/dashboard/timer', 
                        component: Timer,
                        name: 'Timer',
                        
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
