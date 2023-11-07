<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";
import { useRouter, useRoute } from "vue-router";
import { useToast } from "vue-toast-notification";
import "vue-toast-notification/dist/theme-sugar.css";
import VueCookies from "vue-cookies";
import router from "../router";
import { defineEmits } from "vue";

const emit = defineEmits(["userConnected"]);
const showSideNav = ref(false);
const isAdmin = ref(false);

const checkAdmin = () => {
  isAdmin.value = localStorage.getItem("role") === "admin";
};

const toggleSideNav = () => {
  showSideNav.value = !showSideNav.value;
};

onMounted(checkAdmin);
</script>

<template>
  <!-- MENU -->
  <div class="">
    <button
      class="p-4 m-2 bg-blue-800"
      @click="toggleSideNav"
      style="position: fixed; z-index: 100; top: 0px; left: 0px"
    >
      ☰
    </button>

    <div
      class="flex flex-col flex-auto flex-shrink-0 antialiased bg-gray-50 md:block z-50"
      v-show="showSideNav"
    >
      <div
        class="fixed flex flex-col top-0 left-0 w-72 bg-base-100 h-full border-r border-base-200"
        style="z-index: 90"
      >
        <div class="flex items-center justify-center h-14 ml-14 mt-3">
          <h1 class="flex items-center text-2xl font-extrabold">
            TimeManager<span class="scale-150 mr-2 px-2.5 py-0.50 ml-2"
              >🚀</span
            >
          </h1>
        </div>
        <div class="overflow-y-auto overflow-x-hidden flex-grow">
          <ul class="flex flex-col py-4 space-y-1">
            <li class="px-5">
              <div
                class="flex flex-row items-center h-8 border-t border-base-200"
              >
                <div class="text-sm font-light tracking-wide">Menu</div>
              </div>
            </li>
            <li>
              <a
                @click="Dashboard"
                href="#"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-125 justify-center items-center ml-4"
                >
                  📊
                </span>
                <span
                  @click="Dashboard"
                  class="ml-2 text-sm tracking-wide truncate"
                  >Dashboard</span
                >
              </a>
            </li>
            <li v-if="isAdmin">
              <a
                @click="Admin"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-125 justify-center items-center ml-4"
                >
                  🛠
                </span>
                <span
                  @click="Dashboard"
                  class="ml-2 text-sm tracking-wide truncate"
                >
                  Admin Dashboard
                </span>
              </a>
            </li>
            <li>
              <a
                @click="Clock"
                href="#"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-150 justify-center items-center ml-4"
                >
                  ⏱️
                </span>
                <span
                  @click="Clock"
                  class="ml-2 text-sm tracking-wide truncate"
                >
                  My Clock</span
                >
              </a>
            </li>
            <li>
              <a
                @click="workingTimes"
                style="cursor: pointer"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-125 justify-center items-center ml-4"
                >
                  🕝
                </span>
                <span class="ml-2 text-sm tracking-wide truncate"
                  >My Workingtimes</span
                >
              </a>
            </li>
            <li class="px-5">
              <div class="flex flex-row items-center h-8">
                <div class="text-sm font-light tracking-wide">Settings</div>
              </div>
            </li>
            <li>
              <a
                @click="Profile"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-125 justify-center items-center ml-4"
                >
                  👤
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Profile</span>
              </a>
            </li>
            <li>
              <a
                @click="Teams"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-125 justify-center items-center ml-4"
                >
                  👥
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Teams</span>
              </a>
            </li>
            <li>
              <a
                @click="Logout"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span
                  class="inline-flex scale-150 justify-center items-center ml-4"
                >
                  ↪
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Logout</span>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      loading: false,
    };
  },
  methods: {
    Logout() {
      this.isUserConnected = false;
      localStorage.removeItem("userId");
      localStorage.removeItem("role");
      const $toast = useToast();
      $toast.success("You are logged out!");
      localStorage.removeItem("userEmail");
      localStorage.removeItem("userUsername");
      this.isUserConnected = false;
      VueCookies.remove("token");
      router.replace("/");
      this.$emit("userConnected");
    },
    Dashboard() {
      router.push("/dashboard/" + localStorage.getItem("userId"));
    },
    Clock() {
      router.push("/clock/" + localStorage.getItem("userId"));
    },
    Profile() {
      router.push("/Profile/" + localStorage.getItem("userId"));
    },
    workingTimes() {
      router.push("/working-times/" + localStorage.getItem("userId"));
    },
    Admin() {
      router.push("/admin");
    },
    Teams() {
      router.push("/Teams/" + localStorage.getItem("userId"));
    },
  },
};
</script>

<style scoped></style>
