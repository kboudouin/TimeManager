import { createRouter, createWebHistory } from "vue-router";
import ChartManager from "./components/ChartManager.vue";
import Admin from "./components/Admin.vue";
import Clock from "./components/Clock.vue";
import Profile from "./components/Profile.vue";
import wtRender from "./components/workingTimes/wtRender.vue";

const routes = [
  { path: "/Admin", name: "Admin", component: Admin },
  {
    path: "/Dashboard/:id",
    name: "chartManager",
    component: ChartManager,
    props: true,
  },
  { path: "/Clock/:id", component: Clock },
  { path: "/Profile/:id", component: Profile },
  { path: "/working-times/:id", component: wtRender },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
