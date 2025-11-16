  CREATE TABLE teacher_profiles (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT NOT NULL,
    degree TEXT NOT NULL, -- الشهادة
    specialization TEXT NOT NULL, -- التخصص
    experience_years INTEGER NOT NULL, -- سنوات الخبرة
    bio TEXT, -- النبذة
    profile_image_url TEXT, -- رابط الصورة الشخصية
    rating DECIMAL(3,2) DEFAULT 0, -- التقييم العام
    total_ratings INTEGER DEFAULT 0, -- عدد التقييمات
    points INTEGER DEFAULT 0, -- النقاط
    attendance_rate DECIMAL(5,2) DEFAULT 100, -- نسبة الحضور
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')), -- حالة الحساب
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
  );