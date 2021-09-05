package reader

import (
	"fmt"
	"math"
	"math/rand"
	"reflect"
	"testing"
	"time"

	"github.com/theMPatel/streamvbyte-simdgo/pkg/encode"
	"github.com/theMPatel/streamvbyte-simdgo/pkg/stream/writer"
	"github.com/theMPatel/streamvbyte-simdgo/pkg/util"
)

func init() {
	rand.Seed(time.Now().UnixNano())
}

func TestReadAllScalar(t *testing.T) {
	for i := 0; i < 6; i++ {
		count := int(util.RandUint32() % 1e6)
		nums := util.GenUint32(count)
		stream := writer.WriteAllScalar(nums)
		t.Run(fmt.Sprintf("ReadAll: %d", count), func(t *testing.T) {
			out := make([]uint32, count)
			ReadAllScalar(count, stream, out)
			if !reflect.DeepEqual(nums, out) {
				t.Fatalf("decoded wrong nums")
			}
		})
	}
}

func TestReadAllFast(t *testing.T) {
	for i := 0; i < 6; i++ {
		count := int(util.RandUint32() % 1e6)
		nums := util.GenUint32(count)
		stream := writer.WriteAllScalar(nums)
		t.Run(fmt.Sprintf("ReadAll: %d", count), func(t *testing.T) {
			out := make([]uint32, count)
			ReadAllFast(count, stream, out)
			if !reflect.DeepEqual(nums, out) {
				t.Fatalf("decoded wrong nums")
			}
		})
	}
}

var readSinkA []uint32

func BenchmarkReadAllFast(b *testing.B) {
	for i := 0; i < 8; i++ {
		count := int(math.Pow10(i))
		nums := util.GenUint32(count)
		stream := writer.WriteAllScalar(nums)
		out := make([]uint32, count)
		b.Run(fmt.Sprintf("Count_1e%d", i), func(b *testing.B) {
			b.SetBytes(int64(count * encode.MaxBytesPerNum))
			b.ResetTimer()
			for i := 0; i < b.N; i++ {
				ReadAllFast(count, stream, out)
			}
			readSinkA = out
		})
	}
}

var readSinkB []uint32

func BenchmarkFastRead(b *testing.B) {
	count := 4096
	nums := util.GenUint32(count)
	stream := writer.WriteAllScalar(nums)
	per := count * encode.MaxBytesPerNum
	out := make([]uint32, count)
	b.SetBytes(int64(per))
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		ReadAllFast(count, stream, out)
	}
	readSinkB = out
}

var readSinkC []uint32

func BenchmarkReadAllScalar(b *testing.B) {
	for i := 0; i < 8; i++ {
		count := int(math.Pow10(i))
		nums := util.GenUint32(count)
		stream := writer.WriteAllScalar(nums)
		out := make([]uint32, count)
		b.Run(fmt.Sprintf("Count_1e%d", i), func(b *testing.B) {
			b.SetBytes(int64(count * encode.MaxBytesPerNum))
			b.ResetTimer()
			for i := 0; i < b.N; i++ {
				ReadAllScalar(count, stream, out)
			}
			readSinkC = out
		})
	}
}

var readSinkD []uint32

func BenchmarkReadAllScalar1e4(b *testing.B) {
	count := int(math.Pow10(4))
	nums := util.GenUint32(count)
	stream := writer.WriteAllScalar(nums)
	out := make([]uint32, count)

	// 68982
	b.SetBytes(int64(count * encode.MaxBytesPerNum))
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		ReadAllScalar(count, stream, out)
	}
	readSinkD = out
}

func BenchmarkReadAllScalar1e3(b *testing.B) {
	count := int(math.Pow10(3))
	nums := util.GenUint32(count)
	stream := writer.WriteAllScalar(nums)
	out := make([]uint32, count)

	// 2555
	b.SetBytes(int64(count * encode.MaxBytesPerNum))
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		ReadAllScalar(count, stream, out)
	}
	readSinkC = out
}
