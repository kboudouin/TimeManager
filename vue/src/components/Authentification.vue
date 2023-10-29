<script setup>
import { ref } from "vue";
import axios from "axios";
import { useRouter, useRoute } from "vue-router";
import { useToast } from "vue-toast-notification";
import "vue-toast-notification/dist/theme-sugar.css";

const showSideNav = ref(true);

const toggleSideNav = () => {
  showSideNav.value = !showSideNav.value;
};
</script>

<template>
  <!-- IF USER CONNECTED -->
  <!-- MENU -->
  <div class="" v-if="isUserConnected">
    <button
      class="p-2"
      @click="toggleSideNav"
      style="position: fixed; z-index: 100; top: 10px; left: 10px"
    >
      ☰
    </button>
    <div
      class="flex flex-col flex-auto flex-shrink-0 antialiased bg-gray-50 text-gray-800 md:block z-50"
      v-show="showSideNav"
    >
      <div
        class="fixed flex flex-col top-0 left-0 w-72 bg-white h-full border-r"
        style="z-index: 90"
      >
        <div class="flex items-center justify-center h-14 border-b ml-12">
          <h1 class="flex items-center text-2xl font-extrabold">
            TimeManager<span
              class="bg-blue-100 text-blue-800 text-xl font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-blue-200 dark:text-blue-800 ml-2"
              >PRO</span
            >
          </h1>
        </div>
        <div class="overflow-y-auto overflow-x-hidden flex-grow">
          <ul class="flex flex-col py-4 space-y-1">
            <li class="px-5">
              <div class="flex flex-row items-center h-8">
                <div class="text-sm font-light tracking-wide text-gray-500">
                  Menu
                </div>
              </div>
            </li>
            <li>
              <a
                @click="Dashboard"
                href="#"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
                    ></path>
                  </svg>
                </span>
                <span
                  @click="Dashboard"
                  class="ml-2 text-sm tracking-wide truncate"
                  >Dashboard</span
                >
              </a>
            </li>
            <li>
              <a
                @click="Clock"
                href="#"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"
                    ></path>
                  </svg>
                </span>
                <span @click="Clock" class="ml-2 text-sm tracking-wide truncate"
                  >Clock</span
                >
              </a>
            </li>
            <li>
              <a
                @click="workingTimes"
                style="cursor: pointer"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"
                    ></path>
                  </svg>
                </span>
                <span class="ml-2 text-sm tracking-wide truncate"
                  >Workingtimes</span
                >
              </a>
            </li>
            <li class="px-5">
              <div class="flex flex-row items-center h-8">
                <div class="text-sm font-light tracking-wide text-gray-500">
                  Settings
                </div>
              </div>
            </li>
            <li>
              <a
                @click="Profile"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                    ></path>
                  </svg>
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Profile</span>
              </a>
            </li>
            <li>
              <a
                @click="Logout"
                class="relative flex flex-row items-center h-11 focus:outline-none hover:bg-gray-50 text-gray-600 hover:text-gray-800 border-l-4 border-transparent hover:border-indigo-500 pr-6"
              >
                <span class="inline-flex justify-center items-center ml-4">
                  <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"
                    ></path>
                  </svg>
                </span>
                <span class="ml-2 text-sm tracking-wide truncate">Logout</span>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>

  <!-- IF NO USER CONNECTED -->
  <!-- SIGN IN-->
  <div class="" v-if="!isUserConnected">
    <div
      class="p-12 bg-base-300 mx-auto rounded-2xl md:w-fit sm:w-full"
      id="SignInDiv"
      v-if="SignInDiv"
    >
      <div class="mb-4">
        <h3 class="font-semibold text-2xl text-white">Sign In</h3>
        <p class="text-gray-500">Please sign in to your account.</p>
      </div>
      <div class="space-y-5">
        <div class="space-y-2">
          <label class="text-sm font-medium text-white tracking-wide"
            >Username</label
          >
          <input
            v-model="username"
            class="w-full text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type=""
            placeholder="Entrer your username"
          />
        </div>
        <div class="space-y-2">
          <label class="text-sm font-medium text-white tracking-wide"
            >Email</label
          >
          <input
            v-model="email"
            class="w-full text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type=""
            placeholder="Enter your email"
          />
        </div>

        <div>
          <button
            @click="API"
            type="submit"
            class="w-full flex justify-center bg-green-400 hover:bg-green-500 text-gray-100 p-3 rounded-full tracking-wide font-semibold shadow-lg cursor-pointer transition ease-in duration-500"
          >
            SIGN IN
          </button>
        </div>
      </div>

      <div class="pt-5 text-center text-gray-400 text-xs">
        <span>
          <button
            class="text-green hover:text-green-500"
            @click="CreateAccountButton"
          >
            CREATE NEW ACCOUNT
          </button>
        </span>
      </div>
    </div>

    <!-- IF CLICKED CREATE ACCOUNT -->
    <!-- CREATE ACC-->
    <div
      class="p-12 bg-base-300 mx-auto rounded-2xl md:w-fit sm:w-full"
      id="CreateAccountDiv"
      v-show="showCreateAccount"
    >
      <div class="mb-4">
        <h3 class="font-semibold text-2xl text-white">Get Registred</h3>
        <p class="text-gray-500">Create a new user account</p>
      </div>
      <div class="space-y-5">
        <div class="space-y-2">
          <label class="text-sm font-medium text-white tracking-wide"
            >Username</label
          >
          <input
            v-model="username"
            class="w-full text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type=""
            placeholder="Enter your username"
          />
        </div>
        <div class="space-y-2">
          <label class="mb-5 text-sm font-medium text-white tracking-wide">
            Email
          </label>
          <input
            v-model="email"
            class="w-full content-center text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type=""
            placeholder="Enter your email"
          />
        </div>
        <div class="space-y-2">
          <label class="mb-5 text-sm font-medium text-white tracking-wide">
            Comfirm Email
          </label>
          <input
            class="w-full content-center text-base px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-green-400"
            type=""
            placeholder="Confirm your email"
          />
        </div>
        <div class="flex items-center justify-between"></div>
        <div>
          <button
            @click="CreateUSER"
            type="submit"
            class="w-full flex justify-center bg-green-400 hover:bg-green-500 text-gray-100 p-3 rounded-full tracking-wide font-semibold shadow-lg cursor-pointer transition ease-in duration-500"
          >
            CREATE ACCOUNT
          </button>
        </div>
      </div>

      <div class="pt-5 text-center text-gray-400 text-xs">
        <span>
          <button class="text-green hover:text-green-500" @click="Backtologin">
            ALREADY HAVE AN ACCOUNT ? LOG IN HERE
          </button>
        </span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      SignInDiv: true,
      showCreateAccount: false,
      username: "",
      email: "",
      isUserConnected: !!localStorage.getItem("userId"),
    };
  },
  methods: {
    CreateAccountButton() {
      this.SignInDiv = false;
      this.showCreateAccount = !this.showCreateAccount;
    },
    Backtologin() {
      this.SignInDiv = true;
      this.showCreateAccount = false;
    },
    Logout() {
      const $toast = useToast();
      $toast.success("You are logged out!");
      localStorage.removeItem("userEmail");
      localStorage.removeItem("userUsername");
      localStorage.removeItem("userId");
      this.isUserConnected = false;
      window.location = "/";
    },
    Dashboard() {
      window.location = "/chartManager/" + localStorage.getItem("userId");
    },
    Clock() {
      window.location = "/clock/" + localStorage.getItem("userId");
    },
    Profile() {
      window.location = "/Profile/" + localStorage.getItem("userId");
    },
    workingTimes() {
      window.location = "/working-times/" + localStorage.getItem("userId");
    },

    API() {
      console.log("list of users in process...");
      const email1 = this.email;
      const username1 = this.username;

      axios
        .get(`http://44.207.191.254:4000/api/users`, {
          params: {
            email: email1,
            username: username1,
          },
        })
        .then((response) => {
          console.log("Users found");
          console.log(response.data);
          if (response.data.users) {
            const $toast = useToast();
            $toast.success("Logged in!");
            const user = response.data.users[0];
            localStorage.setItem("userEmail", user.email);
            localStorage.setItem("userUsername", user.username);
            localStorage.setItem("userId", user.id);
            this.isUserConnected = true;
            window.location = "/chartManager/" + localStorage.getItem("userId");
          }
        })
        .catch((error) => {
          console.error("API request failed:", error);
        });
    },

    // Méthode pour créer un utilisateur (POST)
    CreateUSER() {
      const username = this.username;
      const email = this.email;
      console.log("Creating user for" + username);
      axios
        .post(
          `http://44.207.191.254:4000/api/users?email=${email}&username=${username}`
        )
        .then((response) => {
          const $toast = useToast();
          $toast.success("Account created! Please login!");
          this.SignInDiv = true;
          this.showCreateAccount = false;
          console.log(response.data);
        })
        .catch((error) => {
          console.error("API request failed: USER FAILED TO BE ADDED", error);
        });
    },

    // Méthode pour obtenir un utilisateur par son ID (GET)
    GetUSERbyID() {
      console.log("Button clicked");
      const userId = 10; //a ajout
      axios
        .get(`http://44.207.191.254:4000/api/users/${userId}`)
        .then((response) => {
          console.log("API response received");
          console.log(response.data);
        })
        .catch((error) => {
          console.error("API request failed:", error);
        });
    },
  },
};
</script>

<style scoped></style>
