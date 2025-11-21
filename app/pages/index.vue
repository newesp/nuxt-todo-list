<template>
  <div class="max-w-3xl mx-auto space-y-6">
    <!-- Page Title -->
    <div class="text-center mb-8 fade-in">
      <h1 class="text-4xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">
        我的待辦事項
      </h1>
      <p class="mt-2 text-gray-600 dark:text-gray-400">{{ todos?.length || 0 }} 項任務</p>
    </div>

    <!-- Add Todo Card -->
    <div class="glass-strong rounded-3xl p-6 shadow-lg card-hover fade-in">
      <form @submit.prevent="addTodo" class="space-y-4">
        <div class="flex gap-3">
          <input
            v-model="newTodo"
            type="text"
            placeholder="添加新任務..."
            class="flex-1 input-apple"
          />
          <button
            type="button"
            @click="showDatePicker = !showDatePicker"
            :class="dueDate ? 'bg-blue-500 text-white' : 'bg-gray-200 dark:bg-gray-700'"
            class="w-12 h-12 rounded-2xl flex items-center justify-center transition-all hover:scale-105"
          >
            <UIcon :name="showDatePicker ? 'i-heroicons-calendar-solid' : 'i-heroicons-calendar'" class="w-5 h-5" />
          </button>
          <button
            type="submit"
            :disabled="!newTodo.trim()"
            class="btn-apple disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <UIcon name="i-heroicons-plus" class="w-5 h-5" />
          </button>
        </div>
        
        <!-- Date Picker -->
        <transition name="slide-fade">
          <div v-if="showDatePicker" class="space-y-2">
            <div class="flex gap-2">
              <input
                v-model="dueDate"
                type="date"
                class="flex-1 input-apple"
                placeholder="選擇日期"
              />
              <input
                v-model="dueTime"
                type="time"
                class="flex-1 input-apple"
                placeholder="選擇時間"
              />
            </div>
            <button
              v-if="dueDate"
              @click="dueDate = ''; dueTime = ''"
              type="button"
              class="px-4 py-2 rounded-xl bg-gray-200 dark:bg-gray-700 hover:bg-gray-300 dark:hover:bg-gray-600 transition-all text-sm"
            >
              清除日期時間
            </button>
          </div>
        </transition>
      </form>
    </div>

    <!-- Todo List -->
    <div class="space-y-3">
      <TransitionGroup name="list">
        <div
          v-for="todo in todos"
          :key="todo.id"
          class="glass-strong rounded-2xl p-5 shadow-md card-hover fade-in"
        >
          <div class="space-y-3">
            <div class="flex items-center gap-4">
              <!-- Custom Checkbox -->
              <input
                type="checkbox"
                v-model="todo.completed"
                @change="toggleTodo(todo)"
                class="checkbox-apple"
              />
              
              <!-- Title -->
              <div v-if="editingTodoId === todo.id && editingField === 'title'" class="flex-1 flex gap-2">
                <input v-model="editTitle" class="flex-1 input-apple" autofocus @keyup.enter="saveEdit(todo.id)" @keyup.esc="cancelEdit" />
                <button @click="saveEdit(todo.id)" class="px-4 py-2 rounded-xl bg-green-500 text-white hover:bg-green-600 transition-all">
                  <UIcon name="i-heroicons-check" class="w-4 h-4" />
                </button>
                <button @click="cancelEdit" class="px-4 py-2 rounded-xl bg-gray-500 text-white hover:bg-gray-600 transition-all">
                  <UIcon name="i-heroicons-x-mark" class="w-4 h-4" />
                </button>
              </div>
              <span
                v-else
                @click="startEditTitle(todo)"
                class="flex-1 text-lg font-medium cursor-pointer px-3 py-2 rounded-xl hover:bg-white/50 dark:hover:bg-black/20 transition-all"
                :class="{ 'text-gray-400 line-through decoration-2': todo.completed }"
              >
                {{ todo.title }}
              </span>
              
              <!-- Delete Button -->
              <button
                v-if="editingTodoId !== todo.id"
                @click="deleteTodo(todo.id)"
                class="w-10 h-10 rounded-full bg-red-500/10 hover:bg-red-500/20 text-red-600 dark:text-red-400 flex items-center justify-center transition-all hover:scale-110"
              >
                <UIcon name="i-heroicons-trash" class="w-5 h-5" />
              </button>
            </div>
            
            <!-- Due Date Badge or Add Date Button -->
            <div v-if="editingTodoId !== todo.id" class="ml-10">
              <!-- Existing Due Date -->
              <button
                v-if="todo.due_date"
                @click="startEditDueDate(todo)"
                :class="getDueDateColorClass(todo.due_date)"
                class="px-4 py-2 rounded-full text-sm font-medium inline-flex items-center gap-2 transition-all hover:scale-105"
              >
                <UIcon name="i-heroicons-calendar" class="w-4 h-4" />
                {{ formatDueDate(todo.due_date) }}
              </button>
              
              <!-- Add Date Button (when no date set) -->
              <button
                v-else
                @click="startEditDueDate(todo)"
                class="px-4 py-2 rounded-full text-sm font-medium inline-flex items-center gap-2 transition-all hover:scale-105 bg-gray-200/50 dark:bg-gray-700/50 text-gray-600 dark:text-gray-400 hover:bg-gray-300/50 dark:hover:bg-gray-600/50"
              >
                <UIcon name="i-heroicons-calendar-plus" class="w-4 h-4" />
                添加日期
              </button>
            </div>
            
            <!-- Edit Due Date -->
            <div v-if="editingTodoId === todo.id && editingField === 'dueDate'" class="ml-10 space-y-2">
              <div class="flex gap-2">
                <input v-model="editDueDateValue" type="date" class="flex-1 input-apple" @keyup.enter="saveEdit(todo.id)" @keyup.esc="cancelEdit" />
                <input v-model="editDueTimeValue" type="time" class="flex-1 input-apple" @keyup.enter="saveEdit(todo.id)" @keyup.esc="cancelEdit" />
              </div>
              <div class="flex gap-2">
                <button @click="saveEdit(todo.id)" class="px-4 py-2 rounded-xl bg-green-500 text-white hover:bg-green-600 text-sm">儲存</button>
                <button @click="cancelEdit" class="px-4 py-2 rounded-xl bg-gray-500 text-white hover:bg-gray-600 text-sm">取消</button>
                <button v-if="editDueDateValue" @click="editDueDateValue = ''; editDueTimeValue = ''" class="px-4 py-2 rounded-xl bg-red-500 text-white hover:bg-red-600 text-sm">移除</button>
              </div>
            </div>
          </div>
        </div>
      </TransitionGroup>

      <!-- Empty State -->
      <div v-if="todos?.length === 0" class="text-center py-16 glass rounded-3xl">
        <div class="w-20 h-20 mx-auto mb-4 rounded-full bg-gradient-to-br from-blue-500/20 to-purple-600/20 flex items-center justify-center">
          <UIcon name="i-heroicons-clipboard-document-list" class="w-10 h-10 text-blue-500" />
        </div>
        <p class="text-xl font-medium text-gray-600 dark:text-gray-400">還沒有任務</p>
        <p class="mt-2 text-sm text-gray-500">開始添加你的第一個待辦事項吧！</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { Database } from '~/types/database.types'

definePageMeta({ middleware: 'auth' })

const supabase = useSupabaseClient<Database>()
const toast = useToast()

const newTodo = ref('')
const dueDate = ref('')
const dueTime = ref('')
const showDatePicker = ref(false)
const adding = ref(false)
const editingTodoId = ref<string | null>(null)
const editingField = ref<'title' | 'dueDate' | null>(null)
const editTitle = ref('')
const editDueDateValue = ref('')
const editDueTimeValue = ref('')

const { data: todos, refresh } = await useAsyncData('todos', async () => {
  const { data } = await supabase.from('todos').select('*').order('created_at', { ascending: false })
  return data || []
})

const formatDueDate = (dateString: string) => {
  const date = new Date(dateString)
  const now = new Date()
  const diffMs = date.getTime() - now.getTime()
  const diffHours = diffMs / (1000 * 60 * 60)
  const formatted = new Intl.DateTimeFormat('zh-TW', { month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' }).format(date)
  if (diffMs < 0) return `逾期 - ${formatted}`
  else if (diffHours < 24) return `即將到期 - ${formatted}`
  else return `到期：${formatted}`
}

const getDueDateColorClass = (dateString: string) => {
  const date = new Date(dateString)
  const now = new Date()
  const diffMs = date.getTime() - now.getTime()
  const diffHours = diffMs / (1000 * 60 * 60)
  if (diffMs < 0) return 'bg-red-500/20 text-red-700 dark:text-red-400'
  else if (diffHours < 24) return 'bg-orange-500/20 text-orange-700 dark:text-orange-400'
  else return 'bg-blue-500/20 text-blue-700 dark:text-blue-400'
}

const parseDateTimeValue = (dateString: string) => {
  const date = new Date(dateString)
  const dateValue = date.toISOString().split('T')[0]
  const timeValue = date.toTimeString().substring(0, 5)
  return { dateValue, timeValue }
}

const startEditTitle = (todo: any) => {
  editingTodoId.value = todo.id
  editingField.value = 'title'
  editTitle.value = todo.title
}

const startEditDueDate = (todo: any) => {
  editingTodoId.value = todo.id
  editingField.value = 'dueDate'
  if (todo.due_date) {
    const { dateValue, timeValue } = parseDateTimeValue(todo.due_date)
    editDueDateValue.value = dateValue
    editDueTimeValue.value = timeValue
  } else {
    editDueDateValue.value = ''
    editDueTimeValue.value = ''
  }
}

const cancelEdit = () => {
  editingTodoId.value = null
  editingField.value = null
  editTitle.value = ''
  editDueDateValue.value = ''
  editDueTimeValue.value = ''
}

const saveEdit = async (todoId: string) => {
  if (editingField.value === 'title' && !editTitle.value.trim()) {
    toast.add({ title: '錯誤', description: '標題不能為空', color: 'error' })
    return
  }
  try {
    const updateData: any = {}
    if (editingField.value === 'title') {
      updateData.title = editTitle.value.trim()
    } else if (editingField.value === 'dueDate') {
      if (editDueDateValue.value) {
        const time = editDueTimeValue.value || '00:00'
        const dateTimeString = `${editDueDateValue.value}T${time}:00`
        updateData.due_date = new Date(dateTimeString).toISOString()
      } else {
        updateData.due_date = null
      }
    }
    const { error } = await supabase.from('todos').update(updateData).eq('id', todoId)
    if (error) throw error
    await refresh()
    cancelEdit()
    toast.add({ title: '更新成功', color: 'success' })
  } catch (error: any) {
    toast.add({ title: '錯誤', description: error.message, color: 'error' })
  }
}

const addTodo = async () => {
  if (!newTodo.value.trim()) return
  adding.value = true
  try {
    const { data: { session } } = await supabase.auth.getSession()
    if (!session?.user?.id) {
      toast.add({ title: 'Error', description: 'Please login first', color: 'error' })
      return
    }
    const insertData: any = { title: newTodo.value, user_id: session.user.id }
    if (dueDate.value) {
      const time = dueTime.value || '00:00'
      const dateTimeString = `${dueDate.value}T${time}:00`
      insertData.due_date = new Date(dateTimeString).toISOString()
    }
    const { error } = await supabase.from('todos').insert(insertData)
    if (error) throw error
    newTodo.value = ''
    dueDate.value = ''
    dueTime.value = ''
    showDatePicker.value = false
    await refresh()
    toast.add({ title: '已添加', color: 'success' })
  } catch (error: any) {
    toast.add({ title: 'Error', description: error.message, color: 'error' })
  } finally {
    adding.value = false
  }
}

const toggleTodo = async (todo: any) => {
  try {
    const { error } = await supabase.from('todos').update({ completed: todo.completed }).eq('id', todo.id)
    if (error) throw error
    await refresh()
  } catch (error: any) {
    toast.add({ title: 'Error', description: error.message, color: 'error' })
    await refresh()
  }
}

const deleteTodo = async (id: string) => {
  try {
    const { error } = await supabase.from('todos').delete().eq('id', id)
    if (error) throw error
    await refresh()
    toast.add({ title: '已刪除', color: 'neutral' })
  } catch (error: any) {
    toast.add({ title: 'Error', description: error.message, color: 'error' })
  }
}
</script>

<style scoped>
.list-enter-active, .list-leave-active {
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}
.list-enter-from {
  opacity: 0;
  transform: translateY(20px) scale(0.95);
}
.list-leave-to {
  opacity: 0;
  transform: translateX(-20px) scale(0.95);
}

.slide-fade-enter-active {
  transition: all 0.3s ease-out;
}
.slide-fade-leave-active {
  transition: all 0.2s cubic-bezier(1, 0.5, 0.8, 1);
}
.slide-fade-enter-from, .slide-fade-leave-to {
  transform: translateY(-10px);
  opacity: 0;
}
</style>
